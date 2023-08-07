module RX_CHECK #(parameter
DATA_WIDTH = 8
) (
input                        clk,
input                        rst,
input                        RX_CHECK_EN,
input                        parity_error,
input                        stop_error,
input      [DATA_WIDTH-1:0]  P_DATA_REG,
output reg                   DATA_VALID,
output reg [DATA_WIDTH-1:0]  P_DATA_OUT
);

always @ (posedge clk or negedge rst)
begin
if (!rst)
    begin
DATA_VALID <= 1'b0;
P_DATA_OUT <= 1'b0;
    end
else if (RX_CHECK_EN )
    begin
if (parity_error || stop_error)
    begin
DATA_VALID <= 1'b0;    
    end
else
    begin    
DATA_VALID <= 1'b1;
P_DATA_OUT <= P_DATA_REG ;
    end
    end
else 
    begin    
DATA_VALID <= 1'b0 ;
    end




end









endmodule