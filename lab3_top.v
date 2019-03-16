`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2019 02:37:26 PM
// Design Name: 
// Module Name: lab3_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab3_top(
    input [3:0] buttons,
    input reset,
    input clk_in,
    output wire [6:0] seg,
    output wire [3:0] an,
    output wire [3:0] redOut,
    output wire [3:0] greenOut,
    output wire [3:0] blueOut,
    output hSync,
    output vSync, 
    output wire d0,             //data in bit
    output wire SCLK,                //10 MHz
    output wire sync,                //Level Triggered Control Input (Active Low)
    output wire locked
    );
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
        
    sine_top sine_inst(reset, clk_10M, d0, SCLK, sync, seg, an, locked);
    moving_block moving_block_inst(buttons, reset, clk_25M, seg, an, redOut, greenOut, blueOut, hSync, vSync);
endmodule
