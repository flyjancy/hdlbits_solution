module top_module (input a, input b, input c, output out);//

wire outn;
andgate inst1 ( .a(a), .b(b), .c(c), .d(1'b1), .e(1'b1), .out(outn) );

assign out = ~outn;

endmodule