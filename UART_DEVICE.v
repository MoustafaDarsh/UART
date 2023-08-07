module UART_DEVICE #(parameter 
DATA_WIDTH = 8,
PAR_EN = 1,
PAR_TYPE = 0,
N = 4 /// oversampling ratio
) (
input                     tx_clk,
input                     rx_clk,
input                     rst,
input  [DATA_WIDTH-1:0]   P_DATA_IN_TX,
input                     DATA_VALID_TX,
input                     RX_IN,
output                    busy_flag_TX,
output                    data_lost_TX,
output                    tx_out,
output                    DATA_VALID_RX,
output                    parity_error_RX,
output                    stop_error_RX,
output [DATA_WIDTH-1:0]   P_DATA_OUT_RX
);





/// INSTANTIATION OF TX AND RX


TX #(
.DATA_WIDTH(DATA_WIDTH),
.PAR_EN(PAR_EN),
.PAR_TYPE(PAR_TYPE)
) TX_insta (
.clk(tx_clk),
.rst(rst),
.P_DATA_from_input(P_DATA_IN_TX),
.DATA_VALID(DATA_VALID_TX),
.tx_out(tx_out),
.busy_flag(busy_flag_TX),
.data_lost(data_lost_TX)
);

//OUT OF TX WILL BE IN OF RX

RX #(
.DATA_WIDTH(DATA_WIDTH),
.N(N),
.PAR_EN(PAR_EN),
.PAR_TYPE(PAR_TYPE)
) RX_insta
(
.clk(rx_clk),
.rst(rst),
.RX_IN(RX_IN),
.DATA_VALID(DATA_VALID_RX),
.parity_error(parity_error_RX),
.stop_error(stop_error_RX),
.P_DATA_OUT(P_DATA_OUT_RX)
);



endmodule