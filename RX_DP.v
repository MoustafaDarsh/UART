module RX_DP #(parameter
DATA_WIDTH = 4,
PAR_TYPE = 1 // 1 FOR ODD PARITY , 0 FOR EVEN PARITY

) (
input                   clk,
input                   rst,
input                   sample_out_reg,
input                   SIPO_EN,
input                   PAR_CHECK_EN,
input                   STOP_CHECK_EN,
input                   RX_CHECK_EN,
output                  SIPO_DONE,
output                  DATA_VALID,
output [DATA_WIDTH-1:0] P_DATA_OUT,
output                  parity_error,
output                  stop_error
);
// INTERNAL SIGNALS 
wire [DATA_WIDTH-1:0] P_DATA_REG ;
















/// INSTANTIATIONS


SIPO #(
.DATA_WIDTH(DATA_WIDTH)
) SIPO_insta (
.clk(clk),
.rst(rst),
.SIPO_EN(SIPO_EN),
.serial_in(sample_out_reg),
.P_DATA_REG(P_DATA_REG),
.SIPO_DONE(SIPO_DONE)
);

PAR_CHECK #(
.DATA_WIDTH(DATA_WIDTH),
.PAR_TYPE(PAR_TYPE)
) PAR_CHECK_insta (
.clk(clk),
.rst(rst),
.PAR_CHECK_EN(PAR_CHECK_EN),
.P_DATA_REG(P_DATA_REG),
.serial_in(sample_out_reg),
.RX_CHECK_EN(RX_CHECK_EN),
.parity_error(parity_error)
);

STOP_CHECK STOP_CHECK_insta (
.clk(clk),
.rst(rst),
.serial_in(sample_out_reg),
.STOP_CHECK_EN(STOP_CHECK_EN),
.RX_CHECK_EN(RX_CHECK_EN),
.stop_error(stop_error)
);

RX_CHECK #(
.DATA_WIDTH(DATA_WIDTH)
) 
RX_CHECK_insta (
.clk(clk),
.rst(rst),
.RX_CHECK_EN(RX_CHECK_EN),
.parity_error(parity_error),
.stop_error(stop_error),
.P_DATA_REG(P_DATA_REG),
.DATA_VALID(DATA_VALID),
.P_DATA_OUT(P_DATA_OUT)
);


endmodule