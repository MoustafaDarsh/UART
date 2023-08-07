module SERIALIZER #(parameter
DATA_WIDTH = 8
) (
input  wire                   clk,
input  wire                   rst,
input  wire [DATA_WIDTH-1:0]  P_DATA_from_input,
input  wire                   Load_from_input,
output reg                    ser_out,
output reg                    ser_done
);
reg [DATA_WIDTH-1:0] P_DATA_REG ;
reg [$clog2(DATA_WIDTH)-1:0] counter ;
wire clear_reg ;
reg ser_busy ;
always @(posedge clk or negedge rst)
begin
if (!rst)
    begin
P_DATA_REG <= 'b0;
ser_out <= 1'b0;
counter <= 'b0;
ser_done <= 1'b0;    
ser_busy <= 1'b0;   
    end

else if (Load_from_input) // LOAD INPUT = DATA_VALID && !busy (so it could be valid only in IDLE state or after stop state)
    begin
P_DATA_REG <= P_DATA_from_input;
ser_out <= 1'b0;
counter <='b0;
ser_done <= 1'b0;     
ser_busy <= 1'b1;   
    end
else if (!ser_busy)
    begin
P_DATA_REG <= 'b0;
ser_out <= 1'b0;
counter <='b0;
ser_done <= 1'b0;     
ser_busy <= 1'b0; 
    end
else if (!clear_reg)
    begin
P_DATA_REG <= {1'b0, P_DATA_REG[DATA_WIDTH-1:1]};
ser_out <= P_DATA_REG[0] ;
counter <= counter + 1'b1 ;   
ser_done <= 1'b0;        
ser_busy <= 1'b1;
    end
else // in case of clear reg = 1
    begin
P_DATA_REG <= 'b0;
ser_out <= P_DATA_REG[0] ;
counter <= 'b0;
ser_done <= 1'b1;
ser_busy <= 1'b0;
    end

end




assign clear_reg = (counter == (DATA_WIDTH-1)) ;








endmodule