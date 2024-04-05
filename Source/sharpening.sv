`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2024 22:53:41
// Design Name: 
// Module Name: convolution
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


module sharpening(
    input clk,
    input [7:0] img[3][3],
    input signed [7:0] fil[3][3],
    output logic signed [width:0] out
    );
    logic signed [width:0] temp [8:0];
    always_ff @(posedge clk) begin
           
//            for(int p=0; p<3; p=p+1)begin
//                for(int q= 0; q<3; q=q+1)begin
//                    temp = temp + fil[p][q]*img[p][q];  
//                end
//            end
            temp[0] = fil[0][0]*img[0][0];
            temp[1] = fil[0][1]*img[0][1];
            temp[2] = fil[0][2]*img[0][2];
            temp[3] = fil[1][0]*img[1][0];
            temp[4] = fil[1][1]*img[1][1];
            temp[5] = fil[1][2]*img[1][2];
            temp[6] = fil[2][0]*img[2][0];
            temp[7] = fil[2][1]*img[2][1];
            temp[8] = fil[2][2]*img[2][2];
            out=temp[0]+temp[1]+temp[2]+temp[3]+temp[4]+temp[5]+temp[6]+temp[7]+temp[8];
          
            
     end
    
endmodule