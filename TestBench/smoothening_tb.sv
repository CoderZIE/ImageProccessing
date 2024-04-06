`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2024 17:01:02
// Design Name: 
// Module Name: smoothening_tb
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


module smoothening_tb();

logic [7:0] A [8:0][1:0];
logic clk;
logic reset;
logic [11:0]out [1:0];
integer i,j;

Smoothening instk(A,out,clk,reset);

initial begin
clk=0;
forever begin
 clk=~clk; #5;
end
end

initial begin

reset = 1; #15

reset = 0;
        for(i = 0; i<2; i=i+1)begin
            for(j=0; j<9; j=j+1)begin
                A[j][i] = 200;
            end
        end
#10

    for(i = 0; i<2; i=i+1)begin
            for(j=0; j<9; j=j+1)begin
                A[j][i] = 20;
            end
        end
        
#10

    for(i = 0; i<2; i=i+1)begin
            for(j=0; j<9; j=j+1)begin
                A[j][i] = 23;
            end
        end
        
#10

$finish;

end



endmodule
