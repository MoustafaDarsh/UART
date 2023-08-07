module TX_CU #(parameter
PAR_EN = 1
) (
input      clk,
input      rst,
input      DATA_VALID,
input      ser_done,
output     Load_from_input,
output reg [1:0] mux_sel,
output reg busy_flag,
output reg data_lost
);
reg busy;






always @(posedge clk or negedge rst)
begin
if (!rst)
    begin
data_lost <= 1'b0;
    end
else if(DATA_VALID && busy)
    begin
data_lost <= 1'b1;
    end
else
    begin
data_lost <= 1'b0;
    end
end

always @ (posedge clk or negedge rst)
begin
if (!rst)
busy_flag <= 1'b0;
else 
busy_flag <= busy ;
end 


/////FSM


localparam [2:0]       IDLE         = 3'b000, 
                       start        = 3'b001,  
                       txing        = 3'b011,
                       parity       = 3'b010,
                       stop         = 3'b110;

//GREY ENCODING..
                      
reg [2:0] current_state, next_state;  
              
    always @(posedge clk or negedge rst)
    begin
        if(!rst)
            current_state <= IDLE;       
        else
            current_state <= next_state;
    end

    always @*
    begin 
        case(current_state)
         
        IDLE : 
        begin
    /////// control signals/////
mux_sel = 2'b01; // output = 1
busy = 0;
    //////// state transition /////
    if (DATA_VALID) 
        begin
    next_state = start ;
        end
    else
        begin
    next_state = IDLE ;
        end
        end                    
 
        start : 
        begin  
    /////// control signals/////
mux_sel = 2'b0; // output = 0 (start_bit)
busy = 1;
    //////// state transition /////
    next_state = txing ;
        end
                
        txing : 
        begin 
    /////// control signals/////
mux_sel = 2'b10; // output = ser_out 
busy = 1;
    //////// state transition /////
    if (ser_done)
    begin
    if (PAR_EN)
        begin
next_state = parity ;
        end
    else
        begin
next_state = stop;
        end
    end
    else
        begin
    next_state = txing;
        end
    end
        parity :
        begin
    /////// control signals/////
mux_sel = 2'b11; // output = par_out 
busy = 1;

    //////// state transition /////
    next_state = stop;
        end
        
        stop :
        begin
    /////// control signals/////
mux_sel = 2'b01; // output = 1(stop bit)
busy = 0;

    //////// state transition /////
if (DATA_VALID)
    next_state = start;
else
    next_state = IDLE;
        end
    

        default : 
        begin  
    /////// control signals/////
mux_sel = 2'b01; // output = 1(stop bit)
busy = 0;

    //////// state transition /////
    next_state = IDLE ;
        end
        endcase
    end  


assign Load_from_input = (DATA_VALID && !busy);






endmodule