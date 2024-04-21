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
    input reset,
    input [8:0] img,
    input stall,
    input clk,
    input signed [20:0] sharpened_image,
    output logic signed [20:0] out);
    
    always_ff@(posedge clk)begin
    if (reset) out=0;
    else begin
    if(stall) out=out;
    else begin
    out=sharpened_image+img;
    end
    end
    end
endmodule