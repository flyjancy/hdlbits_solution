module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err
);

parameter IDLE = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3, S4 = 4'd4, S5 = 4'd5, S6 = 4'd6, S7 = 4'd7, DISC = 4'd8, FLAG = 4'd9, ERR = 4'd10;

reg  [3:0] cur_state, nxt_state;

always @(*) begin
    case (cur_state)
        IDLE : nxt_state = in ? IDLE : S1;
        S1   : nxt_state = in ? S2 : S1;
        S2   : nxt_state = in ? S3 : S1;
        S3   : nxt_state = in ? S4 : S1;
        S4   : nxt_state = in ? S5 : S1;
        S5   : nxt_state = in ? S6 : S1;
        S6   : nxt_state = in ? S7 : DISC;
        S7   : nxt_state = in ? ERR : FLAG;
        DISC : nxt_state = in ? S2 : S1;
        FLAG : nxt_state = in ? S2 : S1;
        ERR  : nxt_state = in ? ERR : S1;
    endcase
end

always @(posedge clk) begin
    if (reset) cur_state <= S1;
    else cur_state <= nxt_state;
end

assign disc = cur_state == DISC;
assign flag = cur_state == FLAG;
assign err  = cur_state == ERR;

endmodule