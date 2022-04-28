module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output [3:0] q
); 

reg  [3:0] q_reg;
wire [3:0] q_reg_nxt = {1'b0, q_reg[3:1]};

always @ (posedge clk or posedge areset) begin
    if (areset) q_reg <= 4'b0;
    else begin
        if (load) q_reg <= data;
        else if (ena) q_reg <= q_reg_nxt;
    end
end

assign q = q_reg;

endmodule