module apb_slave #(
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
    output wire                  pslverr,

    output wire [ADDR_WIDTH-1:0] reg_addr,
    output wire                  reg_wr,
    output wire                  reg_rd,
    output wire [DATA_WIDTH-1:0] reg_wdata,
    output wire [           2:0] reg_pprot,
    output wire [           3:0] reg_pstrb,
    input  wire [DATA_WIDTH-1:0] reg_rdata
);


    assign pready    = 1'b1;
    assign pslverr   = 1'b0;


    assign reg_addr  = paddr;
    assign reg_wr    = psel & penable & pwrite;
    assign reg_rd    = psel & penable & ~pwrite;
    assign reg_wdata = pwdata;
    assign reg_pprot = pprot;
    assign reg_pstrb = pstrb;
    assign prdata    = reg_rdata;

endmodule