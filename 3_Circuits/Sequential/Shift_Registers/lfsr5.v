module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 

reg [4:0] q_reg;

always @(posedge clk) begin
    if (reset) q_reg <= 5'h1;
    else begin
        q_reg[0] <= q_reg[1];
        q_reg[1] <= q_reg[2];
        q_reg[2] <= q_reg[3] ^ q_reg[0];
        q_reg[3] <= q_reg[4];
        q_reg[4] <= q_reg[0];
    end
end

assign q = q_reg;

endmodule