module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum
);

wire [99:0] wc;

genvar i;
generate
    for (i = 0; i < 100; i = i + 1) begin: adder_block
        if (i == 0) begin
            assign sum[i] = a[i] ^ b[i] ^ cin;
            assign wc[i]  = (a[i] & b[i] & !cin) | (!a[i] & b[i] & cin) | (a[i] & !b[i] & cin) | (a[i] & b[i] & cin);
        end
        else begin
            assign sum[i] = a[i] ^ b[i] ^ wc[i-1];
            assign wc[i]  = (a[i] & b[i] & !wc[i-1]) | (!a[i] & b[i] & wc[i-1]) | (a[i] & !b[i] & wc[i-1]) | (a[i] & b[i] & wc[i-1]);
        end
    end
endgenerate

assign cout = wc;

endmodule