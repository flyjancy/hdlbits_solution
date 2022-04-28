module top_module(
    input a,
    input b,
    input c,
    output out 
); 

assign out = b | (~b & c) | (a & ~b & ~c);

endmodule