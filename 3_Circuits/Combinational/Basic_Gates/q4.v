module top_module (
    input x,
    input y,
    output z
);

wire w1 = (x ^ y) & x;
wire w2 = ~(x ^ y);
wire w3 = (x ^ y) & x;
wire w4 = ~(x ^ y);

wire w5 = w1 | w2;
wire w6 = w3 & w4;

assign z = w5 ^ w6;

endmodule