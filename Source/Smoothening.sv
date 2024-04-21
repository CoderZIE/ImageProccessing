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

parameter width = 11; //as maximum 255*9 will be the sum which take 12 bits



module Smoothening(image,out, clk, reset,stall);

input [7:0] image [8:0][1:0]; //8 bit input image.At one time filter will take 9 values and we are calculating 2 pixel at a time.
input stall;
input clk;
input reset;
output logic [width:0]out [1:0];

logic [width:0]temp [1:0];
logic [width:0]temp_out [1:0];

integer i,j;


always_ff @(posedge clk)begin
    if(reset)begin
        for( i =0; i<2; i=i+1)begin
            temp[i]=0;
            temp_out[i]=0;
            
        end
    end
    
    else begin
        if (stall) 
        for(i = 0; i<2; i=i+1)begin
            temp[i]=temp[i];
        end
        else begin
        for(i = 0; i<2; i=i+1)begin
            temp[i]=0;
            for(j=0; j<9; j=j+1)begin
                temp[i] = temp[i]+ image[j][i];
            end
        end
        end
    end
    
end

always_ff @(posedge clk)begin
    if(stall) begin
         temp_out[0]= temp_out[0];
         temp_out[1]= temp_out[1];
         end
    else begin
    temp_out[0]= temp[0]/9;
    temp_out[1]= temp[1]/9;
    end
end


assign    out[0] = temp_out[0];
assign    out[1] = temp_out[1];




endmodule