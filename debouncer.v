`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2019 03:54:15 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer(
 input clk_in,
    input reset,
    input button,
    output button_out
    );
    wire counter_en;
    reg [1:0] cur_state, nex_state;
    reg [31:0] counter;
    parameter [31:0] delay = 2500000; // change the counter based on your frequency 
    parameter [1:0] s0 = 2'b00, s1 = 2'b01, s2 = 2'b10, s3 = 2'b11;

    always @ (posedge clk_in, posedge reset)
        if(reset)
            cur_state <= s0;
        else
            cur_state <= nex_state;

    always @ (posedge clk_in, posedge reset)
        if(reset)
            counter <= 0;
        else
            if(counter_en)
                if(counter == delay)
                    counter <= 0;
                else counter <= counter + 1;
            else counter <= 0;

    assign counter_en = (cur_state == s1 || cur_state == s3);

    always@ (cur_state, button, counter)
        case(cur_state)
            s0:
                if(button)
                    nex_state = s1;
                else
                    nex_state = s0;
            s1:
                if(counter == delay)
                    nex_state = s2;
                else nex_state = s1;
            s2:
                nex_state = s3;
            s3:
                if(counter == delay)
                    nex_state = s0;
                else nex_state = s3;
        endcase

    assign button_out = (cur_state == s2);   
endmodule