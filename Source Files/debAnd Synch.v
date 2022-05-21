`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.05.2022 23:50:30
// Design Name: 
// Module Name: debAnd Synch
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


module debAndSynch(clk,rst,in,out);
    input clk,rst,in;
    output reg out;
    reg[4:0] shiftRegister; 
    always @(posedge clk) begin
        if(rst)
            shiftRegister <= 0;
        else
            out = (shiftRegister[4:2] == 7);
        shiftRegister <= (shiftRegister << 1) + in;
    end
endmodule
