`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NanoDC Lab
// Engineer:  Zaqi Momin
// 
// Create Date: 23.03.2024 15:35:48
// Design Name: 
// Module Name: Smoothening
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

parameter width = 11; //need to be decided



module Smoothening(image,out, clk, reset);

input signed [7:0] image [8:0][1:0];
input clk;
input reset;
output logic signed [width:0]out [1:0];

logic signed [width:0]temp [1:0];
logic signed [width:0]temp_out [1:0];

integer i,j;


always_ff @(posedge clk)begin
    if(reset)begin
        for( i =0; i<4; i=i+1)begin
            temp[i]=0;
        end
    end
    
    else begin
        for(i = 0; i<4; i=i+1)begin
            temp[i]=0;
            for(j=0; j<9; j=j+1)begin
                temp[i] = temp[i]+ image[j][i];
            end
        end
    end
    
end

always_ff @(posedge clk)begin
    temp_out[0]= temp[0]/9;
    temp_out[1]= temp[1]/9;
end


assign    out[0] = temp_out[0];
assign    out[1] = temp_out[1];






endmodule

