module top_module (
    input clk,
    input d,
    output q
);

reg q1, q2;
always @ (posedge clk) q1 <= d ^ q2;
always @ (negedge clk) q2 <= d ^ q1;
assign q = q1 ^ q2;

endmodule