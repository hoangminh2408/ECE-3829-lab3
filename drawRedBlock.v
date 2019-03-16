`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2019 02:47:10 PM
// Design Name: 
// Module Name: drawRedBlock
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


module drawRedBlock(
    input [10:0] hCount,
    input [10:0] vCount,
    input [8:0] xpos,
    input [8:0] ypos,
    input blank,
    output reg redBlock,
    output reg [11:0] stateRedBlock
    );
    //Setting up some color constants, 12-bit RGB
    parameter colorRed = 12'b111100000000;
    parameter colorYellow = 12'b111111110000;
    parameter colorGreen = 12'b000011110000;
    parameter colorBlack = 12'b000000000000;
    parameter colorWhite = 12'b111111111111;
    
    //Block is 32x32
    //640/2 - 32/2 = 304, 640/2 + 32/2 = 336
    always @(hCount or vCount)
        if (32*xpos < hCount &&
            32+ 32*xpos > hCount && 
            vCount > 24*ypos && 
            vCount < 24+24*ypos) 
            redBlock = 1; //Check if pixel (hcount,vcount) is inside the block 
        else redBlock = 0;
    
    always @(hCount or vCount)
        if (blank)
            stateRedBlock = colorBlack; //If blank is 1, we assign the color to black as instructed in the controller module
        else if (redBlock == 1)
            stateRedBlock = colorRed; //If the pixel is inside the block, it is set to red
        else
            stateRedBlock = colorBlack; //Other pixels are black

endmodule
