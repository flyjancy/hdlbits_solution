module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_prev;
always @ (posedge clk) in_prev <= in;
always @ (posedge clk) pedge <= in & ~in_prev;

endmodule