`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.05.2022 23:47:08
// Design Name: 
// Module Name: top_module
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


module top_module(input left, right, clk, rst, output [7:0] cathodes, output [3:0] anodes);
    reg [2:0] state;
    parameter A = 0, B = 1, C = 2, D = 3;
    reg direction;
    wire left_deb, right_deb;
    debAndSynch deb1(clk,rst,left,left_deb);
    debAndSynch deb2(clk,rst,right,right_deb);
    wire rise_left, rise_right;
    edgeDetector edg1(left_deb,clk,rst,rise_left);
    edgeDetector edg2(right_deb,clk,rst,rise_right);
    wire [7:0] segments [3:0];
    reg[3:0]eaten = 4'b0001;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            //segments[0] <= 8'b00010011;
            //segments[1] <= 8'b00011111;
            //segments[2] <= 8'b00010011;
            //segments[3] <= 8'b00010011;
            state <= A;
            direction <= 0;
            eaten <= 4'b0001;
        end
        else begin
            if (rise_left != 0 || rise_right != 0) begin
                case(state)
                    A: if (rise_left) begin
                        state <= D;
                        direction <= 1;
                        eaten[3] <= 1;
                    end
                    else if (rise_right) begin
                        state <= B;
                        direction <= 0;
                        eaten[1] <= 1;
                    end
                    B: if (rise_right) begin
                        state <= C;
                        direction <= 0;
                        eaten[2] <= 1;
                    end
                    else if (rise_left) begin
                        state <= A;
                        direction <= 1;
                        eaten[0] <= 1;
                    end
                    C: if (rise_right) begin
                        state <= D;
                        direction <= 0;
                        eaten[3] <= 1;
                    end
                    else if (rise_left) begin
                        state <= B;
                        direction <= 1;
                        eaten[1] <= 1;
                    end
                    D: if (rise_right) begin
                        state <= A;
                        direction <= 0;
                        eaten[0] <= 1;
                    end
                    else if (rise_left) begin
                        state <= C;
                        direction <= 1;
                        eaten[2] <= 1;
                    end
                endcase
            end
        end
    end
    genvar i;
    generate for (i = 0; i < 4; i = i + 1) begin: displaying_outputs
        segDisplay x(state,i,eaten[i],direction,segments[i]);
    end endgenerate
    digSwitch disp(clk, rst, segments[0], segments[1], segments[2], segments[3], cathodes, anodes);
    
endmodule
