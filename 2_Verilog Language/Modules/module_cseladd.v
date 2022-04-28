module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

wire sel;

add16 add16_inst0 (
     .a    (a[15:0])
    ,.b    (b[15:0])
    ,.cin  (1'b0)
    ,.cout (sel)
    ,.sum  (sum[15:0])
);

wire [15:0] sum1, sum2;

add16 add16_inst1 (
     .a    (a[31:16])
    ,.b    (b[31:16])
    ,.cin  (1'b0)
    ,.cout ()
    ,.sum  (sum1)
);

add16 add16_inst2 (
     .a    (a[31:16])
    ,.b    (b[31:16])
    ,.cin  (1'b1)
    ,.cout ()
    ,.sum  (sum2)
);

assign sum[31:16] = sel ? sum2 : sum1;

endmodule