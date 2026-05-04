module mux #(
	parameter DATA_WIDTH = 200,
	parameter NUM_INPUTS = 2
)(
	input [DATA_WIDTH-1:0] in_1,
	input [DATA_WIDTH-1:0] in_2,
	input sel,
	output reg [DATA_WIDTH-1:0] out
);

	always @(*) begin
		case (sel)
			0: out = in_1;
			1: out = in_2;
		endcase
	end

endmodule