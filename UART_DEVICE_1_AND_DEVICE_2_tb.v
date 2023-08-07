module UART_DEVICE_1_AND_DEVICE_2_tb ();
parameter DATA_WIDTH = 8;
parameter PAR_EN = 1;
parameter PAR_TYPE = 0;
parameter N = 4 ;

reg                     tx_clk_tb ;
reg                     rx_clk_tb ;
reg                     rst_tb ;
reg  [DATA_WIDTH-1:0]   P_DATA_IN_TX_1_tb ;
reg                     DATA_VALID_TX_1_tb ;
reg  [DATA_WIDTH-1:0]   P_DATA_IN_TX_2_tb ;
reg                     DATA_VALID_TX_2_tb ;
wire                    busy_flag_TX_1_tb ;
wire                    data_lost_TX_1_tb ;
wire                    DATA_VALID_RX_1_tb ;
wire                    parity_error_RX_1_tb ;
wire                    stop_error_RX_1_tb ;
wire [DATA_WIDTH-1:0]   P_DATA_OUT_RX_1_tb ;
wire                    busy_flag_TX_2_tb ;
wire                    data_lost_TX_2_tb ;
wire                    DATA_VALID_RX_2_tb ;
wire                    parity_error_RX_2_tb ;
wire                    stop_error_RX_2_tb ;
wire [DATA_WIDTH-1:0]   P_DATA_OUT_RX_2_tb ;



UART_DEVICE_1_AND_DEVICE_2 #(
.DATA_WIDTH(DATA_WIDTH),
.PAR_EN(PAR_EN),
.PAR_TYPE(PAR_TYPE),
.N(N)
) DUT (
.tx_clk(tx_clk_tb),
.rx_clk(rx_clk_tb),
.rst(rst_tb),
.P_DATA_IN_TX_1(P_DATA_IN_TX_1_tb),
.DATA_VALID_TX_1(DATA_VALID_TX_1_tb),
.P_DATA_IN_TX_2(P_DATA_IN_TX_2_tb),
.DATA_VALID_TX_2(DATA_VALID_TX_2_tb),
.busy_flag_TX_1(busy_flag_TX_1_tb),
.data_lost_TX_1(data_lost_TX_1_tb),
.DATA_VALID_RX_1(DATA_VALID_RX_1_tb),
.parity_error_RX_1(parity_error_RX_1_tb),
.stop_error_RX_1(stop_error_RX_1_tb),
.P_DATA_OUT_RX_1(P_DATA_OUT_RX_1_tb),
.busy_flag_TX_2(busy_flag_TX_2_tb),
.data_lost_TX_2(data_lost_TX_2_tb),
.DATA_VALID_RX_2(DATA_VALID_RX_2_tb),
.parity_error_RX_2(parity_error_RX_2_tb),
.stop_error_RX_2(stop_error_RX_2_tb),
.P_DATA_OUT_RX_2(P_DATA_OUT_RX_2_tb)
);



always #5  rx_clk_tb = !rx_clk_tb ;   // period = 10 ns (100 MHz) , rx frequency is N(4) times of tx_clk
always #20  tx_clk_tb = !tx_clk_tb ;   // period = 40 ns (25 MHz)


initial begin
    tx_clk_tb = 1;
    rx_clk_tb = 1;
    rst_tb = 0;
    P_DATA_IN_TX_1_tb = 0;
    DATA_VALID_TX_1_tb = 0;
    P_DATA_IN_TX_2_tb = 0;
    DATA_VALID_TX_2_tb = 0;
   
    #37
    rst_tb = 1;
    #3
    #43
    DATA_VALID_TX_1_tb = 1'b1 ;
    P_DATA_IN_TX_1_tb = 'b11111001 ;
    DATA_VALID_TX_2_tb = 1'b1 ;
    P_DATA_IN_TX_2_tb =  'b10001111 ;
    #40
    DATA_VALID_TX_1_tb = 1'b0;
    P_DATA_IN_TX_1_tb = 'b0 ;
    DATA_VALID_TX_2_tb = 1'b0;
    P_DATA_IN_TX_2_tb = 'b0;
    #400
    DATA_VALID_TX_1_tb = 1'b1;
    P_DATA_IN_TX_1_tb = 'b10000101 ;
    DATA_VALID_TX_2_tb = 1'b1;
    P_DATA_IN_TX_2_tb = 'b00001110 ;
    #40
    DATA_VALID_TX_1_tb = 1'b0;
    P_DATA_IN_TX_1_tb = 'b0 ;
    DATA_VALID_TX_2_tb = 1'b0;
    P_DATA_IN_TX_2_tb = 'b0;
    #120
    DATA_VALID_TX_1_tb = 1'b1 ;
    P_DATA_IN_TX_1_tb = 'b11100011 ;
    DATA_VALID_TX_2_tb = 1'b1 ;
    P_DATA_IN_TX_2_tb =  'b10000000 ;
    #40
    DATA_VALID_TX_1_tb = 1'b0;
    P_DATA_IN_TX_1_tb = 'b0 ;
    DATA_VALID_TX_2_tb = 1'b0;
    P_DATA_IN_TX_2_tb = 'b0;

    #600
    $stop ;
    end










endmodule