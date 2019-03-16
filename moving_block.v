`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2019 12:27:32 AM
// Design Name: 
// Module Name: moving_block
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


module moving_block(
    input [3:0] buttons,
    input reset,
    input clk_in,
    output wire [6:0] segs,
    output wire [3:0] an,
    output reg [3:0] redOut,
    output reg [3:0] greenOut,
    output reg [3:0] blueOut,
    output hSync,
    output vSync 
    );
    

    wire [10:0] hCount; 
    wire [10:0] vCount;
    wire blank;
    
    //12-bit bus for displaying color, we will split this bus into three 4-bit bus to input the r,g,b values into vga_ocontroller
    reg [11:0] color;
    
    //When the value of each of the following wires is 1 on an (hcount,vcount) coordinate, fill in the color of that pixel
    //We use this to draw our red block
    wire redBlock;  
    wire [11:0] stateRedBlock;
    
    //xpos and ypos of the block on the grid, starting position is (9,9)
    reg [7:0] xpos = 9;
    reg [7:0] ypos = 9;
    
    //debounced buttons
    wire[3:0] dbuttons;
        
    //instantiate VGA controller
    vga_controller_640_60 vga (reset, clk_in, hSync, vSync, hCount,vCount, blank);
    //draw the block at (xpos,ypos)
    drawRedBlock (hCount, vCount, xpos, ypos, blank, redBlock, stateRedBlock);
    
    //instantiate debounced button    
    debouncer button0_inst(clk_in, reset, buttons[0], dbuttons[0]);
    debouncer button1_inst(clk_in, reset, buttons[1], dbuttons[1]);
    debouncer button2_inst(clk_in, reset, buttons[2], dbuttons[2]);
    debouncer button3_inst(clk_in, reset, buttons[3], dbuttons[3]);
    
    //move the block depending on which button is pressed
    always @ (posedge clk_in)
    if (reset == 1) 
        begin
            xpos = 8'd9;
            ypos = 8'd9;
        end
    else 
        begin
            if (dbuttons[0] == 1) begin
                if (ypos > 0)
                    ypos <= ypos - 1;
                else
                    ypos <= ypos;
            end
            else if (dbuttons[1] == 1) begin
                if (xpos > 0)
                    xpos <= xpos - 1;
                else 
                    xpos <= xpos;
            end 
            else if (dbuttons[2] == 1) begin
                if (xpos < 19)
                    xpos <= xpos + 1;
                else 
                    xpos <= xpos;
            end
            else if (dbuttons[3] == 1) begin
                if (ypos < 19)
                    ypos <= ypos + 1;
                else
                    ypos <= ypos;
            end
        end
      
    //display the position of the block on the seven-segment display  
    seven_seg ({xpos,ypos}, clk_in, segs, an);    
    
    //output to VGA
    always @(stateRedBlock)
    begin
        color <= stateRedBlock;
        redOut <= color[11:8];
        greenOut <= color[7:4];
        blueOut <= color [3:0];
    end
endmodule
