module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z
);

parameter IDLE = 2'd0, S1 = 2'd1, S2 = 2'd2;

reg [1:0] cur_state, nxt_state;

always @ (*) begin
    case (cur_state)
        IDLE : nxt_state = x ? S1 : IDLE;
        S1   : nxt_state = x ? S1 : S2;
        S2   : nxt_state = x ? S1 : IDLE;
    endcase
end

always @ (posedge clk or negedge aresetn) begin
    if (~aresetn) cur_state <= IDLE;
    else cur_state <= nxt_state;
end

assign z = x & (cur_state == S2);

endmodule