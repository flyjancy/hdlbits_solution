module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
); 

wire [7:0] hh_nxt, mm_nxt, ss_nxt;
reg  [7:0] hh_reg, mm_reg, ss_reg;
reg pm_nxt;
reg pm_reg;

assign ss_nxt[3:0] = ss_reg[3:0] == 4'h9 ? 4'h0 : ss_reg[3:0] + 1'b1;
assign ss_nxt[7:4] = ss_reg[7:4] == 4'h5 ? 4'h0 : ss_reg[7:4] + 1'b1;
assign mm_nxt[3:0] = mm_reg[3:0] == 4'h9 ? 4'h0 : mm_reg[3:0] + 1'b1;
assign mm_nxt[7:4] = mm_reg[7:4] == 4'h5 ? 4'h0 : mm_reg[7:4] + 1'b1;

assign hh_nxt[3:0] = (hh_reg[3:0] == 4'h2 & hh_reg[7:4] == 4'h1) ? 4'h1 : (hh_reg[3:0] == 4'h9 ? 4'h0 : hh_reg[3:0] + 1'b1);
assign hh_nxt[7:4] = (hh_reg[3:0] == 4'h2 & hh_reg[7:4] == 4'h1) ? 4'h0 : hh_reg[7:4] + 1'b1;

assign pm_nxt = (hh_reg == 8'h11 & mm_reg == 8'h59 & ss_reg == 8'h59) ? ~pm_reg : pm_reg;

always @ (posedge clk) begin
    if (reset) begin
        hh_reg <= 8'h12;
        mm_reg <= 8'h00;
        ss_reg <= 8'h00;
        pm_reg <= 1'b0;
    end
    else begin
        if (ena) begin
            ss_reg[3:0] <= ss_nxt[3:0];
            if (ss_reg[3:0] == 4'h9)  ss_reg[7:4] <= ss_nxt[7:4];

            if (ss_reg == 8'h59) begin
                mm_reg[3:0] <= mm_nxt[3:0];
                if (mm_reg[3:0] == 4'h9) mm_reg[7:4] <= mm_nxt[7:4];
            end
            
            if (ss_reg == 8'h59 & mm_reg == 8'h59) begin
                hh_reg[3:0] <= hh_nxt[3:0];
                if (hh_reg[3:0] == 4'h9 | (hh_reg[3:0] == 4'h2 & hh_reg[7:4] == 4'h1)) hh_reg[7:4] <= hh_nxt[7:4];
            end

            pm_reg <= pm_nxt;
        end
    end
end

assign {hh, mm, ss, pm} = {hh_reg, mm_reg, ss_reg, pm_reg};

endmodule