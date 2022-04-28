module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);

parameter S0 = 3'd0, S1 = 3'd1, S2 = 3'd2, S3 = 3'd3, S4 = 3'd4;

reg [2:0] cur_state, nxt_state;

always @ (*) begin
    case (cur_state)
        S0 : nxt_state = x ? S1 : S0;
        S1 : nxt_state = x ? S4 : S1;
        S2 : nxt_state = x ? S1 : S2;
        S3 : nxt_state = x ? S2 : S1;
        S4 : nxt_state = x ? S4 : S3;
        default: nxt_state = S0;
    endcase
end

always @ (posedge clk) begin
    if (reset) cur_state <= S0;
    else cur_state <= nxt_state;
end

assign z = (cur_state == S3) | (cur_state == S4);

endmodule