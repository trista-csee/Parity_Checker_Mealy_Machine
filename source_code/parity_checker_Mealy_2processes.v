module parity_checker_Mealy_2processes (
    input clk, 
    input reset, 
    input x, 
    output reg parity
);
     
parameter S0=0, S1=1;
reg state, nextstate;

// always block to update current state
always @(posedge clk or posedge reset) begin // asynchronous reset
    if (reset)       
        state <= S0; 
    else      
        state <= nextstate; 
end

// always block to compute both output & nextstate
always @(state or x) begin
    parity = 1'b0;     
    
    case(state)        
        S0: if(x) begin                
                parity = 1; 
                nextstate = S1;            
            end            
            else                 
                nextstate = S0;        
        S1: if(x)                 
               nextstate = S0;            
            else begin                 
                parity = 1; 
                nextstate = S1;            
            end        
        default:             
            nextstate = S0;     
    endcase
end

endmodule