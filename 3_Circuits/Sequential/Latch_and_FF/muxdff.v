module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q
);

wire q_nxt = L ? r_in : q_in;
always @(posedge clk) Q <= q_nxt;

endmodule