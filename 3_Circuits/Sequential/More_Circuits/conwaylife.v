module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q
); 
reg [3:0] u, d, l, r;
reg [3:0] cnt [255:0];
reg [255:0] q_nxt;
reg [255:0] q_reg;

always @(*) begin
    for (int i = 0; i < 16; i = i + 1) begin 
        for (int j = 0; j < 16; j = j + 1) begin
            u = i[3:0] + 1;
            d = i[3:0] - 1;
            l = j[3:0] - 1;
            r = j[3:0] + 1;
            cnt[i*16+j] = q[u*16+j] + q[d*16+j] + q[i*16+r] + q[i*16+l] + q[u*16+l] + q[u*16+r] + q[d*16+l] + q[d*16+r];
            q_nxt[i*16+j] = (cnt[i*16+j] == 2) ? q_reg[i*16+j] : (cnt[i*16+j] == 3 ? 1 : 0);
        end
    end     
end
always@(posedge clk) begin
    if (load)
        q_reg <= data;
    else
        q_reg <= q_nxt;
end

assign q = q_reg;

endmodule