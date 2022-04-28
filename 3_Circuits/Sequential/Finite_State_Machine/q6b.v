module top_module (
    input [3:1] y,
    input w,
    output Y2
);

parameter a = 3'd0, b = 3'd1, c = 3'd2, d = 3'd3, e = 3'd4, f = 3'd5;

reg [2:0] nxt_state;

always @(*) begin
    case(y[3:1])
        a : nxt_state = w ? a : b;
        b : nxt_state = w ? d : c;
        c : nxt_state = w ? d : e;
        d : nxt_state = w ? a : f;
        e : nxt_state = w ? d : e;
        f : nxt_state = w ? d : c;
        default : nxt_state = a;
    endcase
end

assign Y2 = nxt_state[1];

endmodule