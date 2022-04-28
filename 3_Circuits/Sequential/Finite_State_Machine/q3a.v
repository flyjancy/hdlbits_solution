module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

parameter A = 1'b0, B = 1'b1;

reg cur_state, nxt_state;

always @(*) begin
    case(cur_state)
        A : nxt_state = s ? B : A;
        B : nxt_state = B;    
    endcase
end

always @(posedge clk) begin
    if (reset) cur_state <= A;
    else cur_state <= nxt_state;
end

reg w1, w2;
always @ (posedge clk) begin
    if (reset) begin
        w1 <= 1'b0;
        w2 <= 1'b0;
    end
    else begin
        w1 <= w;
        w2 <= w1;
    end
end

reg  [1:0] cnt;
wire [1:0] cnt_nxt = cnt == 2'd2 ? 2'd0 : cnt + 1'b1;

always @(posedge clk) begin
    if (reset) cnt <= 2'b0;
    else if (nxt_state) cnt <= cnt_nxt;
    else cnt <= 2'b0;
end

wire flag = (w & w1 & ~w2) | (w & ~w1 & w2) | (~w & w1 & w2);

reg z_reg;
always @ (posedge clk) begin
    if (reset) z_reg <= 1'b0;
    else begin
        if (cur_state && cnt == 2'd0) z_reg <= flag;
        else z_reg <= 1'b0;
    end
end

assign z = z_reg;

endmodule