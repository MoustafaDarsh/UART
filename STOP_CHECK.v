module STOP_CHECK (
input      clk,
input      rst,
input      serial_in,
input      STOP_CHECK_EN,
input      RX_CHECK_EN,
output reg stop_error
);





always @ (posedge clk or negedge rst)
begin
if(!rst)
    begin
stop_error <= 1'b0 ;
    end
else if(STOP_CHECK_EN)
begin
if(!serial_in)
    begin  
stop_error<= 1'b1 ;
    end
else
    begin
stop_error<= 1'b0 ;
    end
end
else if(RX_CHECK_EN)
    begin        
stop_error <=  1'b0 ;
    end
end




endmodule