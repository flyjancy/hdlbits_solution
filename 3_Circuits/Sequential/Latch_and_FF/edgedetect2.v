module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);

reg [7:0] in_prev;
always @ (posedge clk) in_prev <= in;
always @ (posedge clk) anyedge <= in ^ in_prev;

endmodule