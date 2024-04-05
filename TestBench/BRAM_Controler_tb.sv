`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2024 17:01:26
// Design Name: 
// Module Name: BRAM_Controler_tb
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


module BRAM_Controler_tb();
    logic[12:0]address_read;
    logic reset;
    logic [7:0]image_in;
    logic clk;
    logic new_data;
    logic [7:0]image_out;
    
    BRAM_Controler b1(address_read,reset,image_in, clk,new_data,image_out);
    
    initial begin
    clk=0;
    forever begin
     clk=~clk; #5;
    end
    end
    
    initial begin
        reset = 1;
        #10
        
        reset=0;
        image_in=8'd30;
        new_data=1;
        address_read=0;
        #10
        
    
        new_data=0;
        #30
        
        reset =0 ;
        image_in=8'd80;
        new_data=1;
        address_read=0;
        #10
        
        new_data=0;
        #30
        
        reset =0 ;
        image_in=8'd70;
        new_data=1;
        address_read=0;
        #10
        
        new_data=0;
        #30
        
        reset =0 ;
        image_in=8'd20;
        new_data=1;
        address_read=0;
        #10
        
        new_data=0;
        #30
        
     
        address_read=1;
        #10
        address_read=2;
        #10
        address_read=3;
        #12
        
        $finish; 
        
    end
endmodule
