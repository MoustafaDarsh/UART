module RX_tb ();
parameter DATA_WIDTH = 8 ;
parameter N = 16 ;
parameter PAR_EN = 0 ;
parameter PAR_TYPE = 0 ;

reg                   clk_tb ;
reg                   rst_tb ;
reg                   RX_IN_tb ;
wire                  DATA_VALID_tb ;
wire                  parity_error_tb ;
wire                  stop_error_tb ;
wire [DATA_WIDTH-1:0] P_DATA_OUT_tb ;

reg tx_clk_tb ;


RX #(
.DATA_WIDTH(DATA_WIDTH),
.N(N),
.PAR_EN(PAR_EN),
.PAR_TYPE(PAR_TYPE)
) DUT (
.clk(clk_tb),
.rst(rst_tb),
.RX_IN(RX_IN_tb),
.DATA_VALID(DATA_VALID_tb),
.parity_error(parity_error_tb),
.stop_error(stop_error_tb),
.P_DATA_OUT(P_DATA_OUT_tb)
);

always #5  clk_tb = !clk_tb ;   // period = 10 ns (50 MHz)
always #80  tx_clk_tb = !tx_clk_tb ;   // period = 40 ns (50 MHz)

initial begin
    clk_tb = 1;
    tx_clk_tb = 1;
    rst_tb = 0;
    RX_IN_tb = 1;
    #148
    rst_tb = 1;
    #12 // 40
    #160 // 80 
    RX_IN_tb = 0;
    #160 //120
    RX_IN_tb = 1;
    #160 //160
    RX_IN_tb = 1;
    #160 //200
    RX_IN_tb = 0;
    #160
    #160
    RX_IN_tb = 1;
    #160
    #160
    RX_IN_tb = 0;
    #160
    RX_IN_tb = 1;
    //parity
    #160 // 280
    RX_IN_tb = 1;
    //stop
    #160 //320
    RX_IN_tb = 1;
    #160
    #300
    $stop ;
        
        end






endmodule