module Oversampling_by_N #(parameter
N = 8
) (
input      clk,
input      rst,
input      RX_IN,
output     oversampling_tick,
output reg sample_out_reg
);
reg start ;
reg [$clog2(N)-1:0] counter;
reg [1:0] sampled_data ;
wire mid_points_enable ;
wire sample_out ;
/// always block for synchronizing start of oversampling operation
always @(posedge clk or negedge rst)
begin
if (!rst)
    begin
start <= 1'b0;
    end
else
    begin
start <= 1'b1;
    end
end

// always block for counter of oversampling (count from 0 to (N-1)) N : # of oversampling cycles
always @ (posedge clk or negedge rst)
begin
if (!rst)
    begin
counter <= 'b0;
    end
else if (start)
    begin
counter <= counter + 1'b1 ;
    end
end

// always block for sampling operation
always @ (posedge clk or negedge rst)
begin
if (!rst)
    begin
sample_out_reg <= 1'b1;
sampled_data <= 1'b0;
    end
else if (start && mid_points_enable) // start because if N = 4 it will be a problem initially so for safety we add start logic
    begin
sampled_data <= RX_IN + sampled_data ;
    end
else if (oversampling_tick)  //(counter == (N-1)) 
    begin
sample_out_reg <= sample_out ;
sampled_data <= 1'b0;
    end
end




/// assignemnt statements 
assign mid_points_enable = ((counter == (N>>1) - 2) ||(counter == (N>>1) - 1) ||(counter == (N>>1))) ;
assign sample_out = sampled_data [1] ;
assign oversampling_tick = (counter == N-1) ;





endmodule