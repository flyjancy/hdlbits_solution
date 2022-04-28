`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
); 

wire w1 = a & b;
wire w0 = c & d;

assign out = w1 | w0;
assign out_n = ~(w1 | w0);

endmodule
