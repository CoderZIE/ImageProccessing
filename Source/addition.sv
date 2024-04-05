`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 04:01:38 PM
// Design Name: 
// Module Name: addition
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


module addition(
    input [7:0] img,
    input clk,
    input signed [width:0] sharpened_image,
    output logic signed [width:0] out);
    
    always_ff@(posedge clk)begin
    out<=sharpened_image+img;
    end
endmodule