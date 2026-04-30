module bram #(
    parameter BRAM_ADDR_WIDTH = 9,
    parameter BRAM_DATA_WIDTH = 32
)(
    input clk, 
    input [BRAM_ADDR_WIDTH-1:0] addr, 
    input cs_n,
    input wr_n, 
    input rd_n,
    input [BRAM_DATA_WIDTH-1:0] bram_data_in,
    output reg [BRAM_DATA_WIDTH-1:0] bram_data_out
);


    reg [BRAM_DATA_WIDTH-1:0] mem [(1<<BRAM_ADDR_WIDTH)-1:0];

    always @(posedge clk)
        if (cs_n == 1'b0) begin
            begin
                if (wr_n == 1'b1) mem[(addr)] <= bram_data_in;
                if (rd_n == 1'b1) bram_data_out <= mem[addr];
            end
        end
    endmodule