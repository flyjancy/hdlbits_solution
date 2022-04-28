module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

reg [1:0] cur_state;

wire [1:0] nxt_state;

assign nxt_state[0] = (cur_state[0] & ~x);
assign nxt_state[1] = (cur_state[0] & x) | (cur_state[1]);

always @ (posedge clk or posedge areset) begin
    if (areset) cur_state <= 2'b01;
    else cur_state <= nxt_state;
end

reg z_reg;
always @ (posedge clk or posedge areset) begin
    if (areset) z_reg <= 1'b0;
    else z_reg <= (x & cur_state[0]) | (~x & cur_state[1]);
end

assign z = z_reg;

endmodule