module top_module( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum
);

wire [2:0] w;

genvar i;

generate
    for (i = 0 ; i < 4; i = i + 1) begin: adder_block
        if (i == 0) begin
            bcd_fadd add_inst1(
                 .a    (a[i*4+3 -: 4])
                ,.b    (b[i*4+3 -: 4])
                ,.cin  (cin)
                ,.sum  (sum[i*4+3 -: 4])
                ,.cout (w[i])
            );
        end else if (i == 3) begin
            bcd_fadd add_inst2(
                 .a    (a[i*4+3 -: 4])
                ,.b    (b[i*4+3 -: 4])
                ,.cin  (w[i-1])
                ,.sum  (sum[i*4+3 -: 4])
                ,.cout (cout)
            );
        end else begin
            bcd_fadd add_inst3(
                 .a    (a[i*4+3 -: 4])
                ,.b    (b[i*4+3 -: 4])
                ,.cin  (w[i-1])
                ,.sum  (sum[i*4+3 -: 4])
                ,.cout (w[i])
            );
        end
    end
endgenerate

endmodule