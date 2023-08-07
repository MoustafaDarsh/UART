module RX_CU #(parameter
N = 8, //OVERSAMPLING RATIO
PAR_EN = 1
) (
input  clk,
input  rst,
input  RX_IN,
input  SIPO_DONE,
output sample_out_reg,
output SIPO_EN,
output PAR_CHECK_EN,
output STOP_CHECK_EN,
output RX_CHECK_EN
);
// INTERNAL SIGNALS
wire oversampling_tick ;



/// CONTROL SIGNALS PRODUCED BY FSM
reg SIPO_EN_FSM ;
reg PAR_CHECK_EN_FSM ;
reg STOP_CHECK_EN_FSM ;
reg RX_CHECK_EN_FSM ;


/// FSM OF UART RX

localparam [2:0]       WAITING_FOR_START = 3'b000, 
                       RXING             = 3'b001,  
                       PARITY_CHECK      = 3'b011,
                       STOP_CHECK        = 3'b010,
                       RX_CHECK          = 3'b110;

//GREY ENCODING..
                      
reg [2:0] current_state, next_state;  
              
    always @(posedge clk or negedge rst)
    begin
        if(!rst)
            current_state <= WAITING_FOR_START;       
        else
            current_state <= next_state;
    end

    always @*
    begin 
        case(current_state)
         
        WAITING_FOR_START : 
        begin
    /////// control signals/////
    SIPO_EN_FSM = 0;
    PAR_CHECK_EN_FSM = 0;
    STOP_CHECK_EN_FSM = 0;
    RX_CHECK_EN_FSM = 0;
    //////// state transition /////
    if (oversampling_tick && !sample_out_reg ) // means that we received rx_in = 0 that means we have started receiving
        begin
    next_state = RXING ;
        end
    else
        begin
    next_state = WAITING_FOR_START ;
        end
        end                    
 
        RXING : 
        begin  
    /////// control signals/////
    SIPO_EN_FSM = 1;
    PAR_CHECK_EN_FSM = 0;
    STOP_CHECK_EN_FSM = 0;
    RX_CHECK_EN_FSM = 0;
    //////// state transition /////
    if (oversampling_tick && SIPO_DONE ) // means that SIPO FINISHED PROCESSING AND NOW WE WILL RECEIVE PARITY OR STOP BIT
        begin
    if (PAR_EN)
        begin
    next_state = PARITY_CHECK ;        
        end
    else
        begin
    next_state = STOP_CHECK ;
        end
        end
    else
        begin
    next_state = RXING ;
        end
        end
                
        PARITY_CHECK : 
        begin 
    /////// control signals/////
    SIPO_EN_FSM = 0;
    PAR_CHECK_EN_FSM = 1;
    STOP_CHECK_EN_FSM = 0;
    RX_CHECK_EN_FSM = 0;
    //////// state transition /////
    if (oversampling_tick)
        begin
    next_state = STOP_CHECK ;
        end
    else
        begin
    next_state = PARITY_CHECK;
        end
        end
        STOP_CHECK :
        begin
    /////// control signals/////
    SIPO_EN_FSM = 0;
    PAR_CHECK_EN_FSM = 0;
    STOP_CHECK_EN_FSM = 1;
    RX_CHECK_EN_FSM = 0;

    //////// state transition /////
    if (oversampling_tick)
        begin
    next_state = RX_CHECK;
        end
    else
        begin
    next_state = STOP_CHECK ;
        end
        end
        
        RX_CHECK :
        begin
    /////// control signals/////
    SIPO_EN_FSM = 0;
    PAR_CHECK_EN_FSM = 0;
    STOP_CHECK_EN_FSM = 0;
    RX_CHECK_EN_FSM = 1;
    //////// state transition /////
    if (oversampling_tick)
        begin
    if (!sample_out_reg)
        begin
    next_state = RXING ;
        end
    else
        begin
    next_state = WAITING_FOR_START ;
        end
        end
    else
        begin
    next_state = RX_CHECK ;
        end
        end

        default : 
        begin  
    /////// control signals/////
    SIPO_EN_FSM = 0;
    PAR_CHECK_EN_FSM = 0;
    STOP_CHECK_EN_FSM = 0;
    RX_CHECK_EN_FSM = 0;

    //////// state transition /////
    next_state = WAITING_FOR_START ;
        end
        endcase
    end  



/// assignment statements
assign SIPO_EN = SIPO_EN_FSM && oversampling_tick ;
assign PAR_CHECK_EN = PAR_CHECK_EN_FSM && oversampling_tick ;
assign STOP_CHECK_EN = STOP_CHECK_EN_FSM && oversampling_tick ;
assign RX_CHECK_EN = RX_CHECK_EN_FSM && oversampling_tick ;


// INSTANTATION OF OVERSAMPLING MODULE
Oversampling_by_N #(
.N(N)
) 
Oversampling_by_N_insta
(
.clk(clk),
.rst(rst),
.RX_IN(RX_IN),
.oversampling_tick(oversampling_tick),
.sample_out_reg(sample_out_reg)
);











endmodule