module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z
); 

reg  [7:0] q_reg;
wire [7:0] q_nxt = {q_reg[6:0], S};

always @(posedge clk) begin
    if (enable)
        q_reg <= q_nxt;
end

reg z_reg;

always @(*) begin
    case ({A, B, C})
        3'b000: z_reg = q_reg[0];
        3'b001: z_reg = q_reg[1];
        3'b010: z_reg = q_reg[2];
        3'b011: z_reg = q_reg[3];
        3'b100: z_reg = q_reg[4];
        3'b101: z_reg = q_reg[5];
        3'b110: z_reg = q_reg[6];
        3'b111: z_reg = q_reg[7];
    endcase
end

assign Z = z_reg;

endmodule