module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

wire c;

add16 add16_inst0 (
     .a    (a[15:0])
    ,.b    (b[15:0] ^ {16{sub}})
    ,.cin  (sub)
    ,.cout (c)
    ,.sum  (sum[15:0])
);

add16 add16_inst1 (
     .a    (a[31:16])
    ,.b    (b[31:16] ^ {16{sub}})
    ,.cin  (c)
    ,.cout ()
    ,.sum  (sum[31:16])
);

endmodule