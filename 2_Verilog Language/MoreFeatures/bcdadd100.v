module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum
);

wire [99:0] w;

genvar i;
generate
    for (i = 0; i < 100; i = i + 1) begin: bcd_block
         if (i == 0) begin
            bcd_fadd bcd_fadd_inst(
                 .a    (a[i*4+3:i*4])
                ,.b    (b[i*4+3:i*4])
                ,.cin  (cin)
                ,.cout (w[i])
                ,.sum  (sum[i*4+3:i*4])
            );
         end
         else begin
            bcd_fadd bcd_fadd_inst(
                 .a    (a[i*4+3:i*4])
                ,.b    (b[i*4+3:i*4])
                ,.cin  (w[i-1])
                ,.cout (w[i])
                ,.sum  (sum[i*4+3:i*4])
            );
         end
    end
endgenerate

assign cout = w[99];

endmodule