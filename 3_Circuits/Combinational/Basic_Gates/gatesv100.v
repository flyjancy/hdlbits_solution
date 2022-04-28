module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

genvar i;
generate
    for (i = 0; i < 100; i = i + 1) begin: solve_block
        if (i == 0) begin
            assign out_both[i]      = in[i] & in[i+1];
            assign out_different[i] = in[i] ^ in[i+1]; 
        end
        else if (i == 99) begin
            assign out_any[i]       = in[i] | in[i-1];
            assign out_different[i] = in[i] ^ in[0];
        end
        else begin
            assign out_both[i]      = in[i] & in[i+1];
            assign out_different[i] = in[i] ^ in[i+1]; 
            assign out_any[i]       = in[i] | in[i-1];
        end
    end
endgenerate

endmodule