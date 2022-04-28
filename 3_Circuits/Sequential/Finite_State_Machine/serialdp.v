module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

// Modify FSM and datapath from Fsm_serialdata
// FSM from fsm_ps2
// Use FSM from Fsm_serial
parameter IDLE = 3'd0, Da = 3'd1, Ed = 3'd2, Fi = 3'd3, Er = 3'd4;

reg [2:0] cur_state, nxt_state;

reg  [3:0] cnt;
wire [3:0] cnt_nxt = cnt + 1'b1;

always @ (posedge clk) begin
    if (reset) cnt <= 4'b0;
    else begin
        if (cur_state == Da) cnt <= cnt_nxt;
        else cnt <= 4'b0;
    end
end

always @ (*) begin
    case (cur_state)
        IDLE : nxt_state = in ? IDLE : Da;
        Da   : nxt_state = cnt == 4'd8 ? Ed : Da;
        Ed   : nxt_state = in ? Fi : Er;
        Fi   : nxt_state = in ? IDLE : Da;
        Er   : nxt_state = in ? IDLE : Er;
    endcase 
end

always @ (posedge clk) begin
    if (reset) cur_state <= IDLE;
    else cur_state <= nxt_state;
end

// New: Datapath to latch input bits.

reg  [8:0] data;
wire [8:0] data_nxt = {in, data[8:1]};

always @ (posedge clk) begin
    if (reset) data <= 8'b0;
    else begin
        if (cur_state == Da) data <= data_nxt;
        else if (cur_state == Er || cur_state == IDLE) data <= 8'b0;
    end
end

assign out_byte = data[7:0];

// New: Add parity checking.
assign done = cur_state == Fi && (^data);

endmodule