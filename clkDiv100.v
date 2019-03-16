`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2019 01:22:11 PM
// Design Name: 
// Module Name: clkDiv100
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


module clkDiv100(
        input clk_in,     
        output div_clk
        );
        reg clk_out;
        reg [6:0] count100;
        always @ (posedge clk_in) 
            begin
                if (count100 <= 7'd15)
                    begin
                    count100 <= count100 + 1;
                    clk_out <= 0;
                    end
                else if (count100 <= 7'd99)
                    begin
                    count100 <= count100 + 1;
                    clk_out <= 1;
                    end
                else
                    count100 <= 0;
            end    
        assign div_clk = clk_out;
endmodule
