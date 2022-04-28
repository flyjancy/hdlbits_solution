module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//

wire c;

add16 add16_inst0 (
     .a    (a[15:0])
    ,.b    (b[15:0])
    ,.cin  (1'b0)
    ,.cout (c)
    ,.sum  (sum[15:0])
);

add16 add16_inst1 (
     .a    (a[31:16])
    ,.b    (b[31:16])
    ,.cin  (c)
    ,.cout ()
    ,.sum  (sum[31:16])
);

endmodule

module add1 ( input a, input b, input cin, output sum, output cout );

// Full adder module here
assign sum  = a ^ b ^ cin;
assign cout = (a & b & !cin) | (a & !b & cin) | (!a & b & cin) | (a & b & cin);

endmodule
