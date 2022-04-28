module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done
); //

// FSM from fsm_ps2
parameter IDLE = 2'd0, S1 = 2'd1, S2 = 2'd2, S3 = 2'd3;

// State transition logic (combinational)
reg [1:0] cur_state, nxt_state;

always @(*) begin
    case (cur_state)
        IDLE: nxt_state = in[3] ? S1 : IDLE;
        S1  : nxt_state = S2;
        S2  : nxt_state = S3;
        S3  : nxt_state = in[3] ? S1 : IDLE;
        default : nxt_state = IDLE;
    endcase
end

// State flip-flops (sequential)
always @ (posedge clk) begin
    if (reset) cur_state <= IDLE;
    else cur_state <= nxt_state;
end

// Output logic
assign done = cur_state == S3;

// New: Datapath to store incoming bytes.
reg  [23:0] data;
wire [23:0] data_nxt = {data[15:0], in};
always @ (posedge clk)  begin
    if (reset) data <= 24'b0;
    else begin
        if (nxt_state == S1 || nxt_state == S2 || nxt_state == S3)
            data <= data_nxt;
        else 
            data <= 24'b0;
    end
end

assign out_bytes = data;

endmodule