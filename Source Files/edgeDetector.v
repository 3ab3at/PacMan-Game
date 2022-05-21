`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2022 00:19:06
// Design Name: 
// Module Name: edgeDetector
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
module edgeDetector(input sig, clk,rst, output reg z);
    reg[1:0] shiftReg;
    always @(posedge clk, posedge rst) begin
        if (rst) shiftReg <= 0;
        else shiftReg <= (shiftReg << 1) + sig;
        z <= shiftReg == 1;
    end
endmodule
