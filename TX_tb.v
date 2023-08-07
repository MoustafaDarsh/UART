module TX_tb ();
parameter DATA_WIDTH = 8 ;
parameter PAR_EN = 1 ;
parameter PAR_TYPE = 1 ;

reg                  clk_tb ;
reg                  rst_tb ;
reg [DATA_WIDTH-1:0] P_DATA_from_input_tb ;
reg                  DATA_VALID_tb ;
wire                 tx_out_tb ;
wire                 busy_flag_tb ;
wire                 data_lost_tb ;

TX #(
.DATA_WIDTH(DATA_WIDTH),
.PAR_EN(PAR_EN),
.PAR_TYPE(PAR_TYPE)
) DUT 
(
.clk(clk_tb),
.rst(rst_tb),
.P_DATA_from_input(P_DATA_from_input_tb),
.DATA_VALID(DATA_VALID_tb),
.tx_out(tx_out_tb),
.busy_flag(busy_flag_tb),
.data_lost(data_lost_tb)
);



always #20  clk_tb = !clk_tb ;   // period = 10 ns (50 MHz)
initial begin
clk_tb = 1 ;
rst_tb = 0 ;
P_DATA_from_input_tb = 0 ;
DATA_VALID_tb = 0 ;
#37
rst_tb = 1;
#3
#43
P_DATA_from_input_tb = 'b11111001; //DIN1
DATA_VALID_tb =1;
#40
P_DATA_from_input_tb = 'b0;
DATA_VALID_tb =0;
#350 // wait 11 cycle (10 for tx , parity and stop) and 1 for idle
P_DATA_from_input_tb = 'b10000101;//DIN2
DATA_VALID_tb =1 ;
#40
P_DATA_from_input_tb = 'b0;
DATA_VALID_tb =0 ;
#100 // wait 10 cycles untill
P_DATA_from_input_tb = 'b01000000;//DIN3
DATA_VALID_tb =1 ;
#10
P_DATA_from_input_tb = 'b0;
DATA_VALID_tb =0 ;
#40
P_DATA_from_input_tb = 'b11110010;//DIN4
DATA_VALID_tb =1 ;
#10
P_DATA_from_input_tb = 'b0;
DATA_VALID_tb =0 ;
#300
$stop ;
    
    end




endmodule