module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
);  
    reg [1:0] state , nstate;
    reg [2:0] outfr;
    parameter t1 = 2'b00, t2 = 2'b01, t3 = 2'b10, t4 = 2'b11;

    assign {fr3,fr2,fr1} = outfr;

    always@(posedge clk)begin
     if(reset)
            state <= t1;
        else
            state <= nstate;
    end
    
    always @ (*) begin
        nstate = t1;
        case (s)
            3'b000: nstate = t1;
            3'b001: nstate = t2;
            3'b011: nstate = t3;
            3'b111: nstate = t4;
            default: nstate = t1;
        endcase
    end

    always @ (posedge clk) begin
        if (reset)
        	outfr <= 3'b111;     
        else begin
            case (nstate)
                t1:outfr <= 3'b111;
                t2:outfr <= 3'b011;
                t3:outfr <= 3'b001;
                t4:outfr <= 3'b000;
            endcase
        end   
    end

    always @ (posedge clk) begin
        if (reset)
        	dfr <= 1;
        else begin 
            if (nstate < state)
                dfr <= 1;
            else if (nstate > state)
                dfr <= 0;
            else 
                dfr <= dfr;
        end
    end
endmodule