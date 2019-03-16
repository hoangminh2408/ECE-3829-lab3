`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Minh Le
// 
// Create Date: 01/28/2019 12:28:44 AM
// Design Name: 
// Module Name: clkDiv10K
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Dividing clock by 10K (to drive seven segment display)
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clkDiv10K(
        input clk_in,     
        output div_clk
        );
        reg clk_out;
        reg [13:0] count10K;
        
        //Simple clock divider using counter
        always @ (posedge clk_in)
            if (count10K < 5000)
                begin
                    count10K <= count10K + 1;
                    clk_out <= 0;
                end
            else if (count10K < 10000)
                begin
                    count10K <= count10K + 1;
                    clk_out <= 1;
                end
            else 
                begin
                    count10K <= 0;
                end
        assign div_clk = clk_out; 
endmodule
