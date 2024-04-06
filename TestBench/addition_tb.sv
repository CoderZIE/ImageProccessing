`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 04:44:59 PM
// Design Name: 
// Module Name: addition_tb
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


module addition_tb();
    logic clk;
    logic [7:0] img[0:2][0:2];
    logic signed [11:0] sharpened_img[0:2][0:2];
    logic signed [11:0] out[0:2][0:2];
    
    addition add(img,clk,sharpened_img,out);
    
    initial begin
    clk=0; 
    forever begin
    #5 clk=~clk;
    end 
    end
    
    initial begin
    sharpened_img = '{'{0,255,0}, {-1,5,-1}, {0,-1,0}};
    img = '{'{0,25,1}, {2,55,1}, {1,7,1}};
    #10;
    end
endmodule