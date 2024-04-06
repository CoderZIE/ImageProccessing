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
    input [7:0] img [0:2][0:2],
    input clk,
    input signed [11:0] sharpened_image [0:2][0:2],
    output logic signed [11:0] out [0:2][0:2]);
    
    always_ff@(posedge clk)begin
    out[0][0]=sharpened_image[0][0]+img[0][0];
    out[0][1]=sharpened_image[0][1]+img[0][1];
    out[0][2]=sharpened_image[0][2]+img[0][2];
    out[1][0]=sharpened_image[1][0]+img[1][0];
    out[1][1]=sharpened_image[1][1]+img[1][1];
    out[1][2]=sharpened_image[1][2]+img[1][2];
    out[2][0]=sharpened_image[2][0]+img[2][0];
    out[2][1]=sharpened_image[2][1]+img[2][1];
    out[2][2]=sharpened_image[2][2]+img[2][2];
    end
endmodule