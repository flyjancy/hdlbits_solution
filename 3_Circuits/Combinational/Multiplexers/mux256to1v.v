module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [9:0] sel_shift = sel << 2;

assign out = in >> sel_shift;

endmodule