`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Minh Le
// 
// Create Date: 01/28/2019 12:57:23 AM
// Design Name: 
// Module Name: mux4to1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 4 to 1 multiplexer
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux4to1(
    input [3:0] D0,
    input [3:0] D1,
    input [3:0] D2,
    input [3:0] D3,
    input [1:0] S,
    output reg [3:0] Out
    );
    
    //Simple 4 to 1 multiplexer
    always @(*) begin
    case (S)
        2'b00: Out <= D0;
        2'b01: Out <= D1;
        2'b10: Out <= D2;
        2'b11: Out <= D3;
    endcase
    end
endmodule
