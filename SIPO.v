module SIPO #(parameter
DATA_WIDTH = 4
) (
input                       clk,
input                       rst,
input                       SIPO_EN,
input                       serial_in,
output reg [DATA_WIDTH-1:0] P_DATA_REG,
output                      SIPO_DONE
);
reg [$clog2(DATA_WIDTH)-1:0] counter ;

always @ (posedge clk or negedge rst)
begin
if (!rst)
    begin
P_DATA_REG <= 'b0;
counter <= 'b0;
    end
else if (SIPO_EN) /// SIPO_EN = SIPO_EN_FROM_FSM && OVERSAMPLING_TICK 
    begin
P_DATA_REG <= {serial_in,P_DATA_REG[DATA_WIDTH-1:1]} ; // IT TAKES (DATA_WIDTH) CYCLES TO DESERIALZE IT
counter <= counter + 1'b1 ;
    end
end

assign SIPO_DONE = (counter == DATA_WIDTH-1) ;
 
// WHEN IT'S CAPTURED THAT MEAN THAT RECEIVER DESERIALIZED ALL TXED DATA







endmodule