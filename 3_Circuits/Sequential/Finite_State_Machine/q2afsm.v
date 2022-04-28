module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

reg [3:0] cur_state, nxt_state;

assign nxt_state[0] = (cur_state[0] & ~r[1] & ~r[2] & ~r[3]) | (cur_state[1] & ~r[1]) | (cur_state[2] & ~r[2]) | (cur_state[3] & ~r[3]);
assign nxt_state[1] = (cur_state[0] & r[1]) | (cur_state[1] & r[1]);
assign nxt_state[2] = (cur_state[0] & ~r[1] & r[2]) | (cur_state[2] & r[2]);
assign nxt_state[3] = (cur_state[0] & ~r[1] & ~r[2] & r[3]) | (cur_state[3] & r[3]);

always @ (posedge clk) begin
    if (~resetn) cur_state <= 4'b0001;
    else cur_state <= nxt_state;
end

assign g[3:1] = cur_state[3:1];

endmodule