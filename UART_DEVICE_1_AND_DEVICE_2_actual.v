module UART_DEVICE_1_AND_DEVICE_2_actual #(parameter
DATA_WIDTH = 8,
PAR_EN = 1,
PAR_TYPE = 0,
N = 4 /// oversampling ratio
) (
    input                     tx_1_clk,
    input                     tx_2_clk,
    input                     rx_1_clk,
    input                     rx_2_clk,
    input                     rst,
    //dev 1 inputs
    input  [DATA_WIDTH-1:0]   P_DATA_IN_TX_1,
    input                     DATA_VALID_TX_1,
    // dev2 inputs
    input  [DATA_WIDTH-1:0]   P_DATA_IN_TX_2,
    input                     DATA_VALID_TX_2,
    // dev 1 outputs
    output                    busy_flag_TX_1,
    output                    data_lost_TX_1,
    output                    DATA_VALID_RX_1,
    output                    parity_error_RX_1,
    output                    stop_error_RX_1,
    output [DATA_WIDTH-1:0]   P_DATA_OUT_RX_1,
    // dev 2 outputs
    output                    busy_flag_TX_2,
    output                    data_lost_TX_2,
    output                    DATA_VALID_RX_2,
    output                    parity_error_RX_2,
    output                    stop_error_RX_2,
    output [DATA_WIDTH-1:0]   P_DATA_OUT_RX_2
    );
    //INTERNAL SIGNALS INTEFRACING BETWEEN DEVICE 1 AND DEVICE 2
    wire tx_1_out_rx_2_in ;
    wire tx_2_out_rx_1_in ;
    
    
    UART_DEVICE #(
    .DATA_WIDTH(DATA_WIDTH),
    .PAR_EN(PAR_EN),
    .PAR_TYPE(PAR_TYPE),
    .N(N)
    ) DEVICE_1  (
    .tx_clk(tx_1_clk),
    .rx_clk(rx_1_clk),
    .rst(rst),
    .P_DATA_IN_TX(P_DATA_IN_TX_1),
    .DATA_VALID_TX(DATA_VALID_TX_1),
    .RX_IN(tx_2_out_rx_1_in),
    .busy_flag_TX(busy_flag_TX_1),
    .data_lost_TX(data_lost_TX_1),
    .tx_out(tx_1_out_rx_2_in),
    .DATA_VALID_RX(DATA_VALID_RX_1),
    .parity_error_RX(parity_error_RX_1),
    .stop_error_RX(stop_error_RX_1),
    .P_DATA_OUT_RX(P_DATA_OUT_RX_1)
    
    );
    
    UART_DEVICE #(
    .DATA_WIDTH(DATA_WIDTH),
    .PAR_EN(PAR_EN),
    .PAR_TYPE(PAR_TYPE),
    .N(N)
    ) DEVICE_2 (
    .tx_clk(tx_2_clk),
    .rx_clk(rx_2_clk),
    .rst(rst),
    .P_DATA_IN_TX(P_DATA_IN_TX_2),
    .DATA_VALID_TX(DATA_VALID_TX_2),
    .RX_IN(tx_1_out_rx_2_in),
    .busy_flag_TX(busy_flag_TX_2),
    .data_lost_TX(data_lost_TX_2),
    .tx_out(tx_2_out_rx_1_in),
    .DATA_VALID_RX(DATA_VALID_RX_2),
    .parity_error_RX(parity_error_RX_2),
    .stop_error_RX(stop_error_RX_2),
    .P_DATA_OUT_RX(P_DATA_OUT_RX_2)
    );
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    endmodule















