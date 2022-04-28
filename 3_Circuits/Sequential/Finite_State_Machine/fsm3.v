module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    // State transition logic
    parameter A=0, B=1, C=2, D=3;
    reg  [3:0] state;
    wire [3:0] next_state;

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = (state[A] & ~in) | (state[C] & ~in);
    assign next_state[B] = (state[A] & in) | (state[B] & in) | (state[D] & in);
    assign next_state[C] = (state[B] & ~in) | (state[D] & ~in);
    assign next_state[D] = (state[C] & in);
    
    // State flip-flops with asynchronous reset
    always @ (posedge clk or posedge areset) begin
        if (areset) state <= 4'b0001;
        else state <= next_state;
    end

    // Output logic
    assign out = state[D];

endmodule