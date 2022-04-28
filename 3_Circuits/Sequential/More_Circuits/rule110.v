module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 

reg  [511:0] q_reg;
wire [511:0] q_nxt;

genvar i;
generate
    for (i = 0; i < 512; i = i + 1) begin: for_block
        if (i == 0) 
            assign q_nxt[i] = q_reg[i];
        else if (i == 511) 
            assign q_nxt[i] = (q_reg[i] & q_reg[i-1]) | (q_reg[i] ^ q_reg[i-1]);
        else 
            assign q_nxt[i] = (q_reg[i] ^ q_reg[i-1]) | (~q_reg[i+1] & q_reg[i] & q_reg[i-1]);
    end
endgenerate

always @ (posedge clk) begin
    if (load) 
        q_reg <= data;
    else
        q_reg <= q_nxt;
end

assign q = q_reg;

endmodule