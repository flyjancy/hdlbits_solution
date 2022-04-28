module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);

reg [31:0] in_prev;
always @ (posedge clk) in_prev <= in;

wire [31:0] out_nxt = {32{in_prev & ~in}} | out_reg;

reg  [31:0] out_reg;
always @ (posedge clk) begin
    if (reset) out_reg <= 32'b0;
    else out_reg <= out_nxt;
end

assign out = out_reg;

endmodule