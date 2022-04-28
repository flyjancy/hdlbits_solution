module top_module (
    input clk,
    input x,
    output z
); 

reg [2:0] q;
wire [2:0] q_nxt;

assign q_nxt[0] = x ^ q[0];
assign q_nxt[1] = x & ~q[1];
assign q_nxt[2] = x | ~q[2];

always @ (posedge clk) begin
    q <= q_nxt;
end

assign z = ~(|q);

endmodule