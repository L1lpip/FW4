module Bram_init#(
    parameter BRAM_ADDR_WIDTH = 8,
    parameter BRAM_DATA_WIDTH = 200
)(
    input clk,
    input rst_n,

    output reg [BRAM_DATA_WIDTH-1:0] bram_init_out,
    output reg [BRAM_ADDR_WIDTH-1:0] bram_init_addr,
    output reg bram_init_wr_en,
    output reg sel_to_apb
);

    reg init_done;
    reg [BRAM_ADDR_WIDTH:0] counter; 

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            bram_init_out   <= 0;
            bram_init_addr  <= 0;
            bram_init_wr_en <= 0;
            counter         <= 0;
            init_done       <= 0;
            sel_to_apb      <= 0;
        end else begin
            if (!init_done) begin
                bram_init_wr_en <= 1'b1;
                bram_init_addr  <= counter[BRAM_ADDR_WIDTH-1:0];
                bram_init_out   <= 0;
                counter <= counter + 1;

                if (counter == 255) begin
                    init_done <= 1'b1;
                end
            end else begin
                bram_init_wr_en <= 1'b0;
                sel_to_apb      <= 1'b1;
            end
        end
    end

endmodule