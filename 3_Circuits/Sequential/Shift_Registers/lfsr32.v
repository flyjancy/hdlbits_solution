module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 

reg  [31:0] q_reg;
wire [31:0] q_nxt;

genvar i;
generate
    for (i = 0 ; i < 32; i = i + 1) begin: lfsr_block
        if (i == 31) 
            assign q_nxt[i] = q_reg[0];
        else if (i == 21 | i == 1 | i == 0)
            assign q_nxt[i] = q_reg[i+1] ^ q_reg[0];
        else    
            assign q_nxt[i] = q_reg[i+1];
    end
endgenerate

always @ (posedge clk) begin
    if (reset)
        q_reg <= 32'h0001;
    else 
        q_reg <= q_nxt;
end

assign q = q_reg;

endmodule