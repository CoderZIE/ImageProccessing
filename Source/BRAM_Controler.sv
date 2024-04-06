`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2024 21:12:47
// Design Name: 
// Module Name: BRAM_Controler
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


module BRAM_Controler(Recieve,address_read,reset,image_in, clk,new_data,image_out);

input Recieve;
input [12:0]address_read;
input reset;
input [7:0]image_in;
input clk;
input new_data;
output logic [7:0]image_out;

logic [12:0]address_write;
logic [7:0]data_in;
logic [7:0]data_out;
logic enable;
logic [1:0]count; //3 bit counter 0-7
logic [7:0]temp_data_in;
logic prevdata;

design_1_wrapper
   Inst3(address_write,
    clk,
    data_in,
    enable,
    address_read,
    clk,
    image_out);
    
always_ff@(posedge clk)begin
    if(reset)begin
        address_write= 0;
        data_in = 0;
        data_out=0;
        enable = 0;
        count=0;
        prevdata=new_data;
    end
    
    else begin
        if(Recieve)begin
            if(prevdata!=new_data)begin //if new data arrives then it will be loaded in temp_data_in
                data_in = image_in;
                count = 1;
                enable = 1;
                prevdata=new_data;
            end    
            else if(count == 1)begin
                count = count + 1;
            end
            else if(count == 2)begin
                count = count + 1;
            end
            else if(count == 3)begin
                address_write = address_write + 1;
                enable = 0;
                count = count + 1;
            end
        end
        else begin
        //do nothing
        end
    end
    
end

endmodule
