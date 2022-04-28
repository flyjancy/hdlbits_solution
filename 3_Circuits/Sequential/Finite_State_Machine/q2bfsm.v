module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

parameter idle = 1, F = 2, x1 = 3, x2 = 4, keep_g1 = 5, G = 6, y1 = 7, start = 8, keep_g0 = 9;
reg [3:0] state,nxt_state;

always @ (*) begin
    case (state)
        idle : nxt_state = (resetn) ? F : idle;
        F : nxt_state = start;
        start: nxt_state = (x) ? x1 : start;
        x1 : nxt_state = (!x) ? x2 : x1;
        x2 : nxt_state = (x) ? G : start;
        G : nxt_state = (y) ? keep_g1 : y1;
        y1 : nxt_state = (y) ? keep_g1 : keep_g0; 
        keep_g1 :nxt_state = keep_g1;
        keep_g0 :nxt_state = keep_g0;
    endcase
end

always@(posedge clk) begin
    if (~resetn)
        state <= idle;
    else
    state <= nxt_state;
end

assign f = (state == F);
assign g = (state == keep_g1 | state == y1 | state == G);
    
endmodule