`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2024 20:56:16
// Design Name: 
// Module Name: Normalization
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

parameter norm_width = 20;

module Normalization(A, out, clk ,reset);
    
    input clk;
    input reset;
    input logic [norm_width:0]A;
    output logic [norm_width:0]out;
    
    integer max = 255*6;
    integer min = -255*2;
    
    logic signed [norm_width:0]temp;
    logic signed [norm_width:0]temp_out;
    
    always_ff@(posedge clk)begin
        temp = 255*(A - min); 
    end
    
    always_ff@(posedge clk)begin
        temp_out = temp /(max-min);
    end
    
    
    assign   out = temp_out;
    

endmodule
