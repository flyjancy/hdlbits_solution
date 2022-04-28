module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //

wire [3:0] cnt0, cnt1, cnt2;

bcdcount counter0 (clk, reset, c_enable[0], cnt0);
bcdcount counter1 (clk, reset, c_enable[1], cnt1);
bcdcount counter2 (clk, reset, c_enable[2], cnt2);

assign c_enable[2] = cnt1 == 4'd9 & cnt0 == 4'd9;
assign c_enable[1] = cnt0 == 4'd9;
assign c_enable[0] = 1'b1;

assign OneHertz = (cnt0 == 4'd9) & (cnt1 == 4'd9) & (cnt2 == 4'd9);

endmodule