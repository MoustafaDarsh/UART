module PARITY_CALC #(parameter
DATA_WIDTH = 8,
PAR_TYPE = 0  // 0 for even 1 for odd
) (
input                   clk,
input                   rst,
input  [DATA_WIDTH-1:0] in,
input                   Load_from_input,
output                  parity_out
);
reg [DATA_WIDTH-1:0] p_data_reg ;

always @(posedge clk or negedge rst)
begin
if (!rst)
    begin
p_data_reg <= 'b0;
    end        
else if(Load_from_input)
    begin
p_data_reg <= in ;
    end
end

assign parity_out = (!PAR_TYPE) ? ^p_data_reg : ~^p_data_reg ;






endmodule