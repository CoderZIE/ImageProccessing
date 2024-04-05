`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2024 21:18:03
// Design Name: 
// Module Name: normalization_tb
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


module normalization_tb();

    logic clk;
    logic reset;
    logic [norm_width:0]A;
    logic [norm_width:0]out;
    
    Normalization norm(A, out, clk ,reset);
    
    initial begin
    clk=0;
    forever begin
     clk=~clk; #5;
    end
    end
    
    initial begin
        reset = 1;
        #10
        
        reset =0 ;
        A = 234;
        #10
        
        reset = 0 ;
        A= 192;
        
        #10;
        
        $finish; 
        
    end

endmodule
