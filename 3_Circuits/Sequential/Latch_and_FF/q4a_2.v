module top_module (
    input clk,
    input w, R, E, L,
    output Q
);

reg q;
wire d = L ? R : (E ? w : q);
always @(posedge clk) begin
    q <= d;
end

assign Q = q;

endmodule