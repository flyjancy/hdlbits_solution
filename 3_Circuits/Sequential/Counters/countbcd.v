module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q
);

wire [15:0] q_nxt;
reg  [15:0] q_reg;
wire [3:0] flag;

assign flag[0] = q_reg[3:0] == 4'd9;
assign flag[1] = q_reg[7:4] == 4'd9;
assign flag[2] = q_reg[11:8] == 4'd9;
assign flag[3] = q_reg[15:12] == 4'd9;

assign q_nxt[3:0] = flag[0] ? 4'd0 : q_reg[3:0] + 1'b1;
assign q_nxt[7:4] = flag[1] ? 4'd0 : q_reg[7:4] + 1'b1;
assign q_nxt[11:8] = flag[2] ? 4'd0 : q_reg[11:8] + 1'b1;
assign q_nxt[15:12] = flag[3] ? 4'd0 : q_reg[15:12] + 1'b1;

always @(posedge clk) begin
    if (reset) q_reg <= 16'b0;
    else begin
        q_reg[3:0] <= q_nxt[3:0];
        if (flag[0]) q_reg[7:4] <= q_nxt[7:4];
        if (flag[0] & flag[1]) q_reg[11:8] <= q_nxt[11:8];
        if (flag[0] & flag[1] & flag[2]) q_reg[15:12] <= q_nxt[15:12];
    end
end

assign ena = {flag[0] & flag[1] & flag[2], flag[0] & flag[1], flag[0]};

assign q = q_reg;

endmodule