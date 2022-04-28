module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out
);

reg q1, q2, q3;

always @ (posedge clk) begin
    if (~resetn) begin
        q1 <= 1'b0;
        q2 <= 1'b0;
        q3 <= 1'b0;
        out <= 1'b0;
    end
    else begin
        q1 <= in;
        q2 <= q1;
        q3 <= q2;
        out <= q3;
    end
end

endmodule