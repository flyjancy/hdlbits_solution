module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q
);

wire [3:0] q_nxt = q == 4'd9 ? 4'd0 : q+1'b1;

always @(posedge clk) begin
    if (reset) q <= 4'd0;
    else if(slowena) q <= q_nxt;
end

endmodule