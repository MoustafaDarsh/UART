module PAR_CHECK #(parameter
DATA_WIDTH = 8,
PAR_TYPE = 1 //ODD
) (
input                  clk,
input                  rst,
input                  PAR_CHECK_EN,
input [DATA_WIDTH-1:0] P_DATA_REG,
input                  serial_in, //DETECTED PARITY BIT
input                  RX_CHECK_EN,
output   reg           parity_error
);
wire calculated_parity;
always @ (posedge clk or negedge rst)
begin
if (!rst)
    begin
parity_error <= 1'b0;
    end
else if (PAR_CHECK_EN) //PAR_CHECK_EN FROM FSM && OVERSAMPLING TICK
    begin
if (calculated_parity != serial_in)
    begin
parity_error <= 1'b1;
    end
else
    begin
parity_error <= 1'b0;
    end
    end
else if (RX_CHECK_EN)
    begin
parity_error <= 1'b0;
    end
end


assign calculated_parity = (!PAR_TYPE) ? ^P_DATA_REG : ~^P_DATA_REG ; //


endmodule