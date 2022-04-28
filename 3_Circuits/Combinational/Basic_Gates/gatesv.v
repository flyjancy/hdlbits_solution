module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

genvar i;
generate
    for (i = 0; i < 4; i = i + 1) begin: solve_block
        if (i == 0) begin
            assign out_both[i]      = in[i] & in[i+1];
            assign out_different[i] = in[i] ^ in[i+1]; 
        end
        else if (i == 3) begin
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