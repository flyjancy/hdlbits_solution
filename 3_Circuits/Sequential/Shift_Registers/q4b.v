module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //

wire clk = KEY[0];
wire E   = KEY[1];
wire L   = KEY[2];
wire w   = KEY[3];

reg [3:0] q_reg;

always @ (posedge clk) begin
    q_reg[3] <= L ? SW[3] : (E ? w : q_reg[3]);
    q_reg[2] <= L ? SW[2] : (E ? q_reg[3] : q_reg[2]);
    q_reg[1] <= L ? SW[1] : (E ? q_reg[2] : q_reg[1]);
    q_reg[0] <= L ? SW[0] : (E ? q_reg[1] : q_reg[0]);
end

assign LEDR = q_reg;

endmodule