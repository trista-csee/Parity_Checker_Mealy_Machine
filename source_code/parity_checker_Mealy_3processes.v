module parity_checker_Mealy_3processes (
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

// always block to compute output
always @(state or x) begin
    parity = 1'b0;    
    
    case(state)       
        S0: if(x)              
                parity = 1;        
        S1: if(!x)              
                parity = 1;     
    endcase  
end

// always block to compute nextstate
always @(state or x) begin
    nextstate = S0;    
    
    case(state)       
        S0: if(x)              
            nextstate = S1;        
        S1: if(!x)              
            nextstate = S1;        
    endcase
end

endmodule