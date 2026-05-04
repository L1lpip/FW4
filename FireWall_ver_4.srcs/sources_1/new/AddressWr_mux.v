module AddressWr_mux #(
    parameter ADDR_WIDTH = 8
)(
    input wire sel_to_apb,
    input wire [ADDR_WIDTH-1:0] bram_init_addr,
    input wire [ADDR_WIDTH-1:0] pack_to_bram_addr,
    input wire init_wr_en,
    input wire pack_wr_en,
    output wire [ADDR_WIDTH-1:0] mux_out_addr,
    output wire mux_wr_en
);

    assign mux_out_addr = sel_to_apb ? pack_to_bram_addr : bram_init_addr;
    assign mux_wr_en = sel_to_apb ? pack_wr_en : init_wr_en;
endmodule