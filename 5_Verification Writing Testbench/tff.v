module top_module ();

reg clk, reset, t;
wire q;

tff tff_inst(
     .clk   (clk)
    ,.reset (reset)
    ,.t     (t)
    ,.q     (q)
);

initial begin
    clk = 0;
    reset = 1;
    #11 reset = 0; t = 1;
end

always #5 clk = ~clk;

endmodule