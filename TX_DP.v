module TX_DP #(parameter 
DATA_WIDTH = 8,
PAR_TYPE = 0 
) (
input                       clk,
input                       rst,
input [DATA_WIDTH-1:0]      P_DATA_from_input,
input                       Load_from_input,
input [1:0]                 mux_sel,
output reg                  mux_out,        
output                      ser_done

);

wire ser_out ;
wire parity_out ;
reg  mux_out_comb;
always @(*)
begin
case (mux_sel)
2'b00: mux_out_comb = 1'b0;
2'b01: mux_out_comb = 1'b1;
2'b10: mux_out_comb = ser_out ; 
2'b11: mux_out_comb = parity_out ;
default : mux_out_comb = 1'b1;
endcase
end


always @ (posedge clk or negedge rst)
begin
if(!rst)
mux_out <= 1'b1;
else
mux_out <= mux_out_comb ;
end

//insta

SERIALIZER #(
.DATA_WIDTH(DATA_WIDTH)
) 
SERIALIZER_INSTA
(
.clk(clk),
.rst(rst),
.P_DATA_from_input(P_DATA_from_input),
.Load_from_input(Load_from_input),
.ser_out(ser_out),
.ser_done(ser_done)
);

PARITY_CALC #(
.DATA_WIDTH(DATA_WIDTH),
.PAR_TYPE(PAR_TYPE) 
) PARITY_CALC_INSTA
(
.clk(clk),
.rst(rst),
.in(P_DATA_from_input),
.Load_from_input(Load_from_input),
.parity_out(parity_out)
);






endmodule