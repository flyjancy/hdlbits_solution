module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q
);

wire [3:0] q_nxt = q + 1'b1;

always @(posedge clk) begin
    if (reset) q <= 4'b0;
    else q <= q_nxt;
end

endmodule