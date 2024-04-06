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
    logic [7:0] img;
    logic signed [19:0] sharpened_img;
    logic signed [19:0] out;
    
    addition add(img,clk,sharpened_img,out);
    
    initial begin
    clk=0; 
    forever begin
    #5 clk=~clk;
    end 
    end
    
    initial begin
    img=20'd5;
    sharpened_img=20'd8;
    #10;
    end
endmodule