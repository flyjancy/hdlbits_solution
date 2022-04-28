module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena
);

reg [4:0] cur_state, nxt_state;

assign nxt_state[1] = cur_state[0] & ~reset;
assign nxt_state[2] = cur_state[1];
assign nxt_state[3] = cur_state[2];
assign nxt_state[4] = cur_state[3] | cur_state[4];

always @(posedge clk) begin
    if (reset) cur_state <= 5'b00001;
    else cur_state <= nxt_state;
end

assign shift_ena = |cur_state[3:0];

endmodule