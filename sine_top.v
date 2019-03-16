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


module sine_top(
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
    reg dir;           
    reg [4:0] count = 0;
    reg [15:0] shiftreg;
    
    
    //sine wave data point values
    parameter x0 = 8'd0;
    parameter x1 = 8'd2;
    parameter x2 = 8'd10;
    parameter x3 = 8'd21;
    parameter x4 = 8'd37;
    parameter x5 = 8'd57;
    parameter x6 = 8'd79;
    parameter x7 = 8'd103;
    parameter x8 = 8'd128;
    parameter x9 = 8'd152;
    parameter x10 = 8'd176;
    parameter x11 = 8'd198;
    parameter x12 = 8'd218;
    parameter x13 = 8'd234;
    parameter x14 = 8'd245;
    parameter x15 = 8'd253;
    parameter x16 = 8'd255;
    
//Instatiate Clock Wizard

    //Setup clock enable signal for data in for sensor
    assign SCLK = clk_in;
    clkDiv100 div_100_inst (.clk_in(SCLK), .div_clk(sync));
   
    
    // Set d0 equal to 0 through 15 bits of din 
    always @ (negedge SCLK)
    begin
       if (sync == 0)
       begin
            d0 <= shiftreg[15];
            shiftreg <=  {shiftreg[14:0],1'b0};
       end
       else
            shiftreg <= din;
    end
    
    //change value of data to next data point on sine wave
    always @ (posedge sync)
     begin
     case (count) 
       0:  begin
               dir = 0;
               din <= {8'b00000000, x0};
               count = 1;                      
           end
       1:  begin
               din <= {8'b00000000, x1};
               if (dir == 0)
                   count = 2;
               else 
                   count = 0;
           end
       2:  begin
               din <= {8'b00000000, x2};
               if (dir == 0)
                   count = 3;
               else 
                   count = 1;
           end                 
       3:  begin
               din <= {8'b00000000, x3};
               if (dir == 0)
                   count = 4;
               else 
                   count = 2;
           end
       4:  begin
               din <= {8'b00000000, x4};
               if (dir == 0)
                   count = 5;
               else 
                   count = 3;
           end     
       5:  begin
               din <= {8'b00000000, x5};
               if (dir == 0)
                   count = 6;
               else 
                   count = 4;
           end   
       6:  begin
               din <= {8'b00000000, x6};
               if (dir == 0)
                   count = 7;
               else 
                   count = 5;
           end   
       7:  begin
               din <= {8'b00000000, x7};
               if (dir == 0)
                   count = 8;
               else 
                   count = 6;
           end   
       8:  begin
                 din <= {8'b00000000, x8};
                 if (dir == 0)
                     count = 9;
                 else 
                     count = 7;
            end
       9:   begin
                 din <= {8'b00000000, x9};
                 if (dir == 0)
                     count = 10;
                 else 
                     count = 8;
             end
      10:  begin
              din <= {8'b00000000, x10};
              if (dir == 0)
                  count = 11;
              else 
                  count = 9;
          end
      11:  begin
              din <= {8'b00000000, x11};
              if (dir == 0)
                  count = 12;
              else 
                  count = 10;
          end                 
      12:  begin
              din <= {8'b00000000, x12};
              if (dir == 0)
                  count = 13;
              else 
                  count = 11;
          end
      13:  begin
              din <= {8'b00000000, x13};
              if (dir == 0)
                  count = 14;
              else 
                  count = 12;
          end     
      14:  begin
              din <= {8'b00000000, x14};
              if (dir == 0)
                  count = 15;
              else 
                  count = 13;
          end   
      15:  begin
              din <= {8'b00000000, x15};
              if (dir == 0)
                  count = 16;
              else 
                  count = 14;
          end
      16:  begin
                dir = 1;
                din <= {8'b00000000, x16};
                count = 15;                      
            end                                                                                                                                            
   endcase
   end
    
//    assign d0 = din[15];
endmodule
