module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

assign z = (y == 3'b011) | (y == 3'b100);
assign Y0 = (y == 3'b000 & x) | (y == 3'b001 & ~x) | (y == 3'b010 & x) | (y == 3'b011 & ~x) | (y == 3'b100 & ~x);

endmodule