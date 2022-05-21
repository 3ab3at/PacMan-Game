`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.05.2022 23:34:26
// Design Name: 
// Module Name: segDisplay
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


module segDisplay(state,idx, eaten, direction, cathodes);
    input [2:0] idx;
    input [2:0] state;
    input direction,eaten;
    output reg [7:0] cathodes;
    parameter A = 0, B = 1, C = 2, D = 3;
    wire [7:0] pacman_r = 8'b01100011, pacman_l = 8'b00001111, cheese = 8'b11111101, OFF = 8'b11111111;
    always @(idx) begin
        case (state)
            A: if(idx == 0) cathodes <= (direction) ? pacman_l : pacman_r;
               else cathodes <= (eaten) ? OFF : cheese;
            B: if (idx == 1) cathodes <= (direction) ? pacman_l : pacman_r;
               else cathodes <= (eaten) ? OFF : cheese;
            C: if (idx == 2) cathodes <= (direction) ? pacman_l : pacman_r;
               else cathodes <= (eaten) ? OFF : cheese;
            D: if (idx == 3) cathodes <= (direction) ? pacman_l : pacman_r;
               else cathodes <= (eaten) ? OFF : cheese;
       endcase
    end   
endmodule
