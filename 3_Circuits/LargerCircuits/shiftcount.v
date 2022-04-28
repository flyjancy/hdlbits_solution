module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q
);

reg  [3:0] q_reg;
wire [3:0] q_s = {q_reg[2:0], data};
wire [3:0] q_c = (q_reg == 4'd0) ? 4'hf : q_reg - 1'b1;

always @ (posedge clk) begin
    if (shift_ena) q_reg <= q_s;
    else if (count_ena) q_reg <= q_c;
end

assign q  = q_reg;

endmodule