module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum
);

wire [1:0] w;

genvar i;

generate
    for (i = 0 ; i < 3; i = i + 1) begin: adder_block
        if (i == 0) begin
            add1 add1_inst1(
                 .a    (a[i])
                ,.b    (b[i])
                ,.cin  (cin)
                ,.sum  (sum[i])
                ,.cout (w[i])
            );
        end else if (i == 2) begin
            add1 add1_inst2(
                 .a    (a[i])
                ,.b    (b[i])
                ,.cin  (w[i-1])
                ,.sum  (sum[i])
                ,.cout (cout[i])
            );
        end else begin
            add1 add1_inst3(
                 .a    (a[i])
                ,.b    (b[i])
                ,.cin  (w[i-1])
                ,.sum  (sum[i])
                ,.cout (w[i])
            );
        end
    end
endgenerate

assign cout[1:0] = w;

endmodule

module add1 ( input a, input b, input cin, output sum, output cout );

// Full adder module here
assign sum  = a ^ b ^ cin;
assign cout = (a & b & !cin) | (a & !b & cin) | (!a & b & cin) | (a & b & cin);

endmodule