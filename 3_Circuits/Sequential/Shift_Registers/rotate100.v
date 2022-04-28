module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output [99:0] q
); 

reg  [99:0] q_reg;
wire [99:0] q_nxtl, q_nxtr;

assign q_nxtl = {q_reg[98:0], q_reg[99]};
assign q_nxtr = {q_reg[0], q_reg[99:1]};

always @ (posedge clk) begin
    if (load) q_reg <= data;
    else begin
        if (~ena[1] & ena[0])
            q_reg <= q_nxtr;
        if (ena[1] & ~ena[0])
            q_reg <= q_nxtl;
    end
end

assign q = q_reg;

endmodule