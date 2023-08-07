module TX #(parameter
DATA_WIDTH = 8,
PAR_EN = 1,
PAR_TYPE = 1
)(
input clk,
input rst,
input [DATA_WIDTH-1:0] P_DATA_from_input,
input DATA_VALID,
output tx_out,
output busy_flag,
output data_lost
);
//INTERNAL SIGNALS
wire ser_done ;
wire Load_from_input ;
wire [1:0] mux_sel ;


// CU INSTA

TX_CU #(
.PAR_EN(PAR_EN)
) TX_CU_INSTA 
(
.clk(clk),
.rst(rst),
.DATA_VALID(DATA_VALID),
.ser_done(ser_done),
.Load_from_input(Load_from_input),
.mux_sel(mux_sel),
.busy_flag(busy_flag),
.data_lost(data_lost)
);


// DP INSTA

TX_DP #( 
.DATA_WIDTH(DATA_WIDTH),
.PAR_TYPE(PAR_TYPE) 
) TX_DP_INSTA 
(
.clk(clk),
.rst(rst),
.P_DATA_from_input(P_DATA_from_input),
.Load_from_input(Load_from_input),
.mux_sel(mux_sel),
.mux_out(tx_out),
.ser_done(ser_done)
);







endmodule