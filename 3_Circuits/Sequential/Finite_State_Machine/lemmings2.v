module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

parameter LEFT = 2'b00, RIGHT = 2'b01, FALLL = 2'b10, FALLR = 2'b11;

reg [1:0] state, nxt_state;

always @(*) begin
    case(state)
        LEFT:  nxt_state = ~ground ? FALLL : (bump_left  ? RIGHT : LEFT);
        RIGHT: nxt_state = ~ground ? FALLR : (bump_right ? LEFT  : RIGHT);
        FALLL: nxt_state = ~ground ? FALLL : LEFT;
        FALLR: nxt_state = ~ground ? FALLR : RIGHT;
    endcase
end

always @(posedge clk, posedge areset) begin
   if (areset) state <= LEFT;
   else state <= nxt_state;
end

assign walk_left  = state == LEFT;
assign walk_right = state == RIGHT;
assign aaah       = (state == FALLL) | (state == FALLR);

endmodule