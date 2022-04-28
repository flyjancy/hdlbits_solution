module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y
);

wire w0 = p2a & p2b;
wire w1 = p2c & p2d;
assign p2y = w0 | w1;

wire w2 = p1a & p1b & p1c;
wire w3 = p1d & p1e & p1f;
assign p1y = w2 | w3;

endmodule