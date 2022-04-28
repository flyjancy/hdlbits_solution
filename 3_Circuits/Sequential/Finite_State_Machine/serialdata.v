module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

// Use FSM from Fsm_serial
parameter IDLE = 3'd0, Da = 3'd1, Ed = 3'd2, Fi = 3'd3, Er = 3'd4;

reg [2:0] cur_state, nxt_state;

reg  [2:0] cnt;
wire [2:0] cnt_nxt = cnt + 1'b1;

always @ (posedge clk) begin
    if (reset) cnt <= 3'b0;
    else begin
        if (cur_state == Da) cnt <= cnt_nxt;
        else cnt <= 3'b0;
    end
end

always @ (*) begin
    case (cur_state)
        IDLE : nxt_state = in ? IDLE : Da;
        Da   : nxt_state = cnt == 3'd7 ? Ed : Da;
        Ed   : nxt_state = in ? Fi : Er;
        Fi   : nxt_state = in ? IDLE : Da;
        Er   : nxt_state = in ? IDLE : Er;
    endcase 
end

always @ (posedge clk) begin
    if (reset) cur_state <= IDLE;
    else cur_state <= nxt_state;
end

assign done = cur_state == Fi;

// New: Datapath to latch input bits.

reg  [7:0] data;
wire [7:0] data_nxt = {in, data[7:1]};

always @ (posedge clk) begin
    if (reset) data <= 8'b0;
    else begin
        if (cur_state == Da) data <= data_nxt;
        else if (cur_state == Er || cur_state == IDLE) data <= 8'b0;
    end
end

assign out_byte = data;

endmodule