module RX #(parameter
DATA_WIDTH = 4,
N=4, // OVERSAMPLING RATIO
PAR_EN = 1, 
PAR_TYPE = 1 // 1 FOR ODD , 0 FOR EVEN
) (
input                   clk,
input                   rst,
input                   RX_IN,
output                  DATA_VALID,
output                  parity_error,
output                  stop_error,
output [DATA_WIDTH-1:0] P_DATA_OUT
);
// INTERNAL SIGNALS INTERFACTING BETWEEN CU AND DP
wire SIPO_DONE ;
wire sample_out_reg ;
wire SIPO_EN ;
wire PAR_CHECK_EN ;
wire STOP_CHECK_EN ;
wire RX_CHECK_EN ;

RX_CU #(
.N(N),
.PAR_EN(PAR_EN)
) 
RX_CU_insta
(
.clk(clk),
.rst(rst),
.RX_IN(RX_IN),
.SIPO_DONE(SIPO_DONE),
.sample_out_reg(sample_out_reg),
.SIPO_EN(SIPO_EN),
.PAR_CHECK_EN(PAR_CHECK_EN),
.STOP_CHECK_EN(STOP_CHECK_EN),
.RX_CHECK_EN(RX_CHECK_EN)
);

RX_DP #(
.DATA_WIDTH(DATA_WIDTH),
.PAR_TYPE(PAR_TYPE)
)
RX_DP_insta (
.clk(clk),
.rst(rst),
.sample_out_reg(sample_out_reg),
.SIPO_EN(SIPO_EN),
.PAR_CHECK_EN(PAR_CHECK_EN),
.STOP_CHECK_EN(STOP_CHECK_EN),
.RX_CHECK_EN(RX_CHECK_EN),
.SIPO_DONE(SIPO_DONE),
.DATA_VALID(DATA_VALID),
.P_DATA_OUT(P_DATA_OUT),
.parity_error(parity_error),
.stop_error(stop_error)
);




endmodule