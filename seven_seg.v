`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Minh Le
// 
// Create Date: 01/22/2019 02:42:00 AM
// Design Name: 
// Module Name: seven_seg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Seven segment display module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seven_seg(
    input [15:0] data,
    input clk_in,
    output wire [6:0] segs,
    output reg [3:0] an
    );
    
    reg [1:0] count;
    wire [3:0] sseg;
    wire clk_10K;
    
    //Divide 25MHz clock to 2500Hz clock to drive the 7-segment display
    clkDiv10K div_10k (clk_in, clk_2500); 
    
    //Counter to cycle between anodes
    always @ (posedge clk_2500)
        begin
            if (count == 2'b00) 
                begin
                    count <= 2'b01;
                end
            else if (count == 2'b01)
                begin
                    count <= 2'b10;
                end
            else if (count == 2'b10)
                begin
                    count <= 2'b11;
                end
            else if (count == 2'b11)
                begin
                    count <= 2'b00;
                end
        end
    
    //Multiplexer to cycle between cathodes.
    mux4to1 mux_1 (data[3:0], data[7:4], data[11:8], data[15:12], count, sseg);
    
    //Convert hex number to seven segment display 
    hex2seg seg_1 (sseg, segs); 
    
    //Cycle between anodes
    always @(*)
        begin
            if (count == 2'b00) 
                begin
                    an <= 4'b1110; //Activate first anode
                end
            else if (count == 2'b01)
                begin
                    an <= 4'b1101; //Activate second anode
                end
            else if (count == 2'b10)
                begin
                    an <= 4'b1011; //Activate third anode
                end
            else if (count == 2'b11)
                begin
                    an <= 4'b0111; //Activate fourth anode 
                end
        end
endmodule
