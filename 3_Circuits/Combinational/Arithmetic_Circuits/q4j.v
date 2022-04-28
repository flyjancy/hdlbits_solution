module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum
);

wire [2:0] w;

genvar i;

generate
    for (i = 0 ; i < 4; i = i + 1) begin: adder_block
        if (i == 0) begin
            add1 add1_inst1(
                 .a    (x[i])
                ,.b    (y[i])
                ,.cin  (1'b0)
                ,.sum  (sum[i])
                ,.cout (w[i])
            );
        end else if (i == 3) begin
            add1 add1_inst2(
                 .a    (x[i])
                ,.b    (y[i])
                ,.cin  (w[i-1])
                ,.sum  (sum[i])
                ,.cout (sum[i+1])
            );
        end else begin
            add1 add1_inst0(
                 .a    (x[i])
                ,.b    (y[i])
                ,.cin  (w[i-1])
                ,.sum  (sum[i])
                ,.cout (w[i])
            );
        end
    end
endgenerate

endmodule

module add1 ( input a, input b, input cin, output sum, output cout );

// Full adder module here
assign sum  = a ^ b ^ cin;
assign cout = (a & b & !cin) | (a & !b & cin) | (!a & b & cin) | (a & b & cin);

endmodule