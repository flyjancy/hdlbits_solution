module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

always @ (posedge clk) 
    if (a == b) state <= a;

assign q = a ^ b ^ state;

endmodule