`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 04:34:48 PM
// Design Name: 
// Module Name: sharpening_tb
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


module sharpening_tb();
    logic clk;
    logic [7:0] img [3][3];
    logic [7:0] fil [3][3];
    logic signed [19:0] out;
    sharpening sh1(clk,img,fil,out);
    initial begin
    clk=0; 
    forever begin
    #5 clk=~clk;
    end 
    end
    
    initial begin
    fil =  '{{1,2,1},{2,4,2},{1,2,1}};
    img =  '{{0,2,1},{2,4,1},{1,0,1}};
    #100;

end    
endmodule