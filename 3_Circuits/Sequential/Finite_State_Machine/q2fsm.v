module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z
);

parameter a = 3'd0, b = 3'd1, c = 3'd2, d = 3'd3, e = 3'd4, f = 3'd5;

reg [2:0] cur_state, nxt_state;

always @(*) begin
    case(cur_state)
        a : nxt_state = w ? b : a;
        b : nxt_state = w ? c : d;
        c : nxt_state = w ? e : d;
        d : nxt_state = w ? f : a;
        e : nxt_state = w ? e : d;
        f : nxt_state = w ? c : d;
        default : nxt_state = a;
    endcase
end

always @ (posedge clk) begin
    if (reset) cur_state <= a;
    else cur_state <= nxt_state;
end

assign z = (cur_state == e) | (cur_state == f);

endmodule