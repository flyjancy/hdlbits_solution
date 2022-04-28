module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR
);  // Q

reg [2:0] q_reg;

wire clk = KEY[0];
wire L   = KEY[1];

always @(posedge clk)begin
    q_reg[0] <= L ? SW[0] : q_reg[2];
    q_reg[1] <= L ? SW[1] : q_reg[0];
    q_reg[2] <= L ? SW[2] : q_reg[1] ^ q_reg[2];
end

assign LEDR = q_reg;

endmodule