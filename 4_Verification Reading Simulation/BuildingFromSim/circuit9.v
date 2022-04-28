module top_module (
    input clk,
    input a,
    output [3:0] q
);

reg [3:0] q_reg;
wire [3:0] q_nxt = q_reg == 4'd6 ? 4'd0 : q_reg + 1'b1;
always @ (posedge clk) begin
    if (a) q_reg <= 4'd4;
    else q_reg <= q_nxt;
end

assign q = q_reg;

endmodule