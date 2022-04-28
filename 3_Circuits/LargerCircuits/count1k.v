module top_module (
    input clk,
    input reset,
    output [9:0] q
);

reg  [9:0] q_reg;
wire [9:0] q_nxt = q_reg == 10'd999 ? 10'd0 : q_reg + 1'b1;

always @(posedge clk) begin
    if (reset) q_reg <= 10'd0;
    else q_reg <= q_nxt;
end

assign q = q_reg;

endmodule