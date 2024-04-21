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

parameter norm_width = 21;

module Normalization(A, out, clk ,reset,stall);
    
    input clk;
    input reset;
    input stall;
    input logic signed  [norm_width:0]A;
    output logic signed [norm_width+8:0]out; //30 bit as 255(8 bit)  and A(22 bit)
    integer signed max=1530;
    integer signed min=-510;
    
    logic signed [norm_width+8:0]temp;
    logic signed [norm_width+8:0]temp_out;
    
    always_ff@(posedge clk)begin
        if(reset) temp=0;
        else begin
        if(stall) temp=temp;
        else begin
            temp = 255*(A - min); 
            end  
        end 
    end
    
    always_ff@(posedge clk)begin
        if(reset) temp_out=0;
        else begin
        if(stall) temp_out=temp_out;
        else temp_out = temp /(max-min);
        end
    end
    
    
    assign   out = temp_out;
    

endmodule