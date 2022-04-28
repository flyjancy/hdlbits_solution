module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
); 

parameter LEFT = 3'd0, RIGHT = 3'd1, DIGL = 3'd2, DIGR = 3'd3, FALLL = 3'd4, FALLR = 3'd5;

reg [2:0] state, nxt_state;

always @ (*) begin
    case (state)
        LEFT  : nxt_state = ~ground ? FALLL : (dig ? DIGL : (bump_left ? RIGHT : LEFT));
        RIGHT : nxt_state = ~ground ? FALLR : (dig ? DIGR : (bump_right ? LEFT : RIGHT));
        DIGL  : nxt_state = ~ground ? FALLL : DIGL;
        DIGR  : nxt_state = ~ground ? FALLR : DIGR;
        FALLL : nxt_state = ground ? LEFT : FALLL;
        FALLR : nxt_state = ground ? RIGHT: FALLR;
    endcase
end

always @(posedge clk, posedge areset) begin
   if (areset) state <= LEFT;
   else state <= nxt_state;
end

assign walk_left  = state == LEFT;
assign walk_right = state == RIGHT;
assign aaah       = (state == FALLL) | (state == FALLR);
assign digging    = (state == DIGL) | (state == DIGR);

endmodule