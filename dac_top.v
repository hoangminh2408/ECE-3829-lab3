`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: WPI
// Engineer: 
// Shannon McCormack, Minh Le
// Create Date: 02/07/2019 02:37:01 PM
// Design Name: 
// Module Name: dac_top
// Project Name:Lab 3 
// Target Devices:
// Tool Versions: 
// Description: Generate sine wave from DAC
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dac_top(
    input [7:0] sw,
    input reset,
    input clk_in,
    output reg d0,             //data in bit
    output wire SCLK,                //10 MHz
    output wire sync,                //Level Triggered Control Input (Active Low)
    output wire [6:0] seg,
    output wire [3:0] an,
    output wire locked
    );
        
//Set bits [15:8] to zero, [7:0] are data bits from switches
    reg [15:0] din;                    
    
//Instatiate Clock Wizard
    clk_wiz_0 instance_name
       (
        // Clock out ports
        .clk_10M(clk_10M),     // output clk_10M
        .clk_25M(clk_25M),     // output clk_25M
        // Status and control signals
        .reset(reset), // input reset
        .locked(locked),       // output locked
       // Clock in ports
        .clk_in1(clk_in));      // input clk_in
    
    //Setup clock enable signal for data in for sensor
    assign SCLK = clk_10M;
    clkDiv100 div_100_inst (.clk_in(SCLK), .div_clk(sync));
   
    
    // Set d0 equal to 0 through 15 bits of din 
    always @ (negedge SCLK)
    begin
       if (sync == 0)
       begin
            d0 <= din[15];
            din <=  {din[14:0],1'b0};
       end
       else 
            din <= {8'b00000000, sw[7:0]};
    end
    
//    assign d0 = din[15];
    
    
    seven_seg seg_inst_1({8'b00000000,sw[7:0]},clk_25M,seg,an);
endmodule
