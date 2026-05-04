module Bram_init#(
	parameter BRAM_ADDR_WIDTH = 8,
	parameter BRAM_DATA_WIDTH = 200
)(
	input clk,
	input rst_n,

	output reg [BRAM_DATA_WIDTH-1:0] bram_init_out,
	output reg [BRAM_ADDR_WIDTH-1:0] bram_init_addr,
	output reg bram_init_wr_en,
	output wire sel_to_apb
);
	
	integer i;
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			bram_init_out <= 0;
			bram_init_addr <= 0;
			bram_init_wr_en <= 0;
		end else begin
			for (i = 0; i < 256; i = i + 1) begin
				bram_init_out <= {200{1'b0}} | i;
				bram_init_addr <= i[BRAM_ADDR_WIDTH-1:0];
				bram_init_wr_en <= 1'b1;
			end
		end
	end

	assign sel_to_apb = (i == 256) ? 1'b1 : 1'b0;

endmodule