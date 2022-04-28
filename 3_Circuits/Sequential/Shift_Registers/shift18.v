module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output [63:0] q
); 

reg  [63:0] q_reg;
wire [63:0] q_nxt_l1 = {q_reg[62:0], 1'b0};
wire [63:0] q_nxt_l8 = {q_reg[55:0], 8'b0};
wire [63:0] q_nxt_r1 = {q_reg[63], q_reg[63:1]};
wire [63:0] q_nxt_r8 = {{8{q_reg[63]}}, q_reg[63:8]};

always @(posedge clk) begin
    if (load)
        q_reg <= data;
    else if (ena) begin
        case(amount)
            2'b00: q_reg <= q_nxt_l1;
            2'b01: q_reg <= q_nxt_l8;
            2'b10: q_reg <= q_nxt_r1;
            2'b11: q_reg <= q_nxt_r8;
            default: q_reg <= 64'b0;
        endcase
    end
end

assign q = q_reg;

endmodule