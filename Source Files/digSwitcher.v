`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2022 00:55:55
// Design Name: 
// Module Name: digSwitch
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


module digSwitch(clk, rst, digit0, digit1, digit2, digit3, out, enable);
    input clk, rst;
    input[7:0] digit0, digit1, digit2, digit3;
    output reg[7:0] out;
    output reg[3:0] enable;
    wire[7:0] digits[3:0];
    assign digits[0] = digit0; assign digits[1] = digit1; assign digits[2] = digit2; assign digits[3] = digit3;
    wire clk_100Hz;
    clockDivider #(50000) divide(clk, rst, clk_100Hz);
    reg[1:0] cnt;
    always @(posedge clk_100Hz, posedge rst) begin
        if (rst) cnt <= 0;
        else cnt <= cnt + 1;
        out = digits[cnt];
        enable = 4'b1111 - (1 << cnt);
    end
endmodule
