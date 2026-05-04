`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2026 10:48:26 PM
// Design Name: 
// Module Name: FireWall_top
// Project Name: FireWall
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Fire_wall_top #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk,
    input wire rst_n,

    input  wire [ADDR_WIDTH-1:0] paddr,
    input  wire                  psel,
    input  wire                  penable,
    input  wire                  pwrite,
    input  wire [DATA_WIDTH-1:0] pwdata,
    input  wire [           2:0] pprot,
    input  wire [           3:0] pstrb,
    output wire [DATA_WIDTH-1:0] prdata,
    output wire                  pready,
    output wire                  pslverr

    // input wire       in_valid,
    // input wire       in_last,
    // input wire [7:0] in_data,

	// output wire       out_valid,
	// output wire       out_last,
	// output wire [7:0] out_data,
	// output wire [8:0] out_user_id
);

    wire [ADDR_WIDTH-1:0] reg_addr;
    wire                  reg_wr;
    wire                  reg_rd;
    wire [DATA_WIDTH-1:0] reg_wdata;
    wire [           2:0] reg_pprot;
    wire [           3:0] reg_pstrb;
    wire [DATA_WIDTH-1:0] reg_rdata;

    apb_slave #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) apb_inst (
        .clk(clk),
        .rst_n(rst_n),
        .paddr(paddr),
        .psel(psel),
        .penable(penable),
        .pwrite(pwrite),
        .pwdata(pwdata),
        .pprot(pprot),
        .pstrb(pstrb),
        .prdata(prdata),
        .pready(pready),
        .pslverr(pslverr),
        .reg_addr(reg_addr),
        .reg_wr(reg_wr),
        .reg_rd(reg_rd),
        .reg_wdata(reg_wdata),
        .reg_pprot(reg_pprot),
        .reg_pstrb(reg_pstrb),
        .reg_rdata(reg_rdata)
    );

    wire [7:0] w_pack_bram_address;
    wire w_pack_bram_wr_en;
    wire w_pack_bram_rd_en;
    wire [200:0] w_pack_bram_data_in;
    wire [200:0] w_pack_bram_data_out;

    FireWall_Pack #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) pack_inst (
        .clk(clk),
        .rst_n(rst_n),
        .reg_addr(reg_addr),
        .reg_wr(reg_wr),
        .reg_rd(reg_rd),
        .reg_wdata(reg_wdata),
        .reg_rdata(reg_rdata),
        .addr(w_pack_bram_address),
        .wr_en(w_pack_bram_wr_en),
        .rd_en(w_pack_bram_rd_en),
        .bram_data_in(w_pack_bram_data_in),
        .bram_data_out(w_pack_bram_data_out)
        );

	wire sel_to_apb;
	wire [200:0] bram_init_data_in;
	wire [200:0] mux_out;
    wire [7:0] w_bram_init_address;
    wire w_bram_init_wr_en;

	Bram_init #(
		.BRAM_ADDR_WIDTH(8),
		.BRAM_DATA_WIDTH(200)
	) bram_init_inst (
		.clk(clk),
		.rst_n(rst_n),
		.bram_init_out(bram_init_data_in),
		.bram_init_addr(w_bram_init_address),
		.bram_init_wr_en(w_bram_init_wr_en),
		.sel_to_apb(sel_to_apb)
	);

	mux #(
		.DATA_WIDTH(200),
		.NUM_INPUTS(2)
	) mux_inst (
		.in_1(bram_init_data_in),
		.in_2(w_pack_bram_data_in),
		.sel(sel_to_apb),
		.out(mux_out)
	);

    wire w_mux_wr_en;
    wire [7:0] w_mux_out_addr;

    AddressWr_mux #(
        .ADDR_WIDTH(8)
    ) addr_mux_inst (
        .sel_to_apb(sel_to_apb),
        .bram_init_addr(w_bram_init_address),
        .pack_to_bram_addr(w_pack_bram_address),
        .init_wr_en(w_bram_init_wr_en),
        .pack_wr_en(w_pack_bram_wr_en),
        .mux_out_addr(w_mux_out_addr),
        .mux_wr_en(w_mux_wr_en)
    );


    bram #(
        .BRAM_ADDR_WIDTH(8),
        .BRAM_DATA_WIDTH(200)
    ) bram_inst (
        .clk(clk),
        .addr(w_mux_out_addr),
        .cs_n(0),
        .wr_n(w_mux_wr_en),
        .rd_n(w_pack_bram_rd_en),
        .bram_data_in(mux_out),
        .bram_data_out(w_pack_bram_data_out)
    );

endmodule