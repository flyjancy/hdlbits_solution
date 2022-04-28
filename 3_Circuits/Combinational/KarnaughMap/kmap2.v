module top_module(
    input a,
    input b,
    input c,
    input d,
    output out
); 

assign out = (~a & b & ~c & ~d) | (~b & ~c) | (~a & c & ~d) | (b & c & d) | (a & ~b & c & d);

endmodule