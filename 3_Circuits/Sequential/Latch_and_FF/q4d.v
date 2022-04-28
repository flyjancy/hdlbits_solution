module top_module (
    input clk,
    input in, 
    output out
);

reg q;
wire q_nxt = q ^ in;
always @(posedge clk) q <= q_nxt;
assign out = q;

endmodule