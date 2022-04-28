module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting
);

parameter IDLE = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;

reg  [2:0] cur_state, nxt_state;

always @ (*) begin
    case (cur_state) 
        IDLE : nxt_state = data ? S1 : IDLE;
        S1   : nxt_state = data ? S2 : IDLE;
        S2   : nxt_state = data ? S2 : S3;
        S3   : nxt_state = data ? S4 : IDLE;
        S4   : nxt_state = S4;
        default : nxt_state = IDLE;
    endcase 
end

always @ (posedge clk) begin
    if (reset) cur_state <= IDLE;
    else cur_state <= nxt_state;
end

always @ (posedge clk) begin
    if (reset) start_shifting <= 1'b0;
    else start_shifting <= nxt_state == S4;
end

endmodule