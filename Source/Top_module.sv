`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NanoDC Lab
// Engineer: 
// 
// Create Date: 03.04.2024 14:53:15
// Design Name: Image Enchancement Hardware
// Module Name: Top_module
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


module Top_module(fil,stall,Recieve, RxD, TxD, clk, reset, Transmitt, done, done_out,data_in_pp,address);

input stall;
output [12:0]address;
input [7:0]data_in_pp;
input RxD;
input Recieve; //button to start recieving 
input Transmitt; //button to start transmitting
input clk;
input reset;
input logic signed [7:0] fil[0:2][0:2];
input done; //to indicate that we have recieved the required data
output done_out; //to indicate that we have successfully processed the data
output logic TxD;


//Internal Variables for Top Module
logic [7:0]RxData;
logic [7:0]data_in;
logic isNewData;
logic doTransmit;
logic isBusy;
logic [7:0]TxData;
logic [12:0]address;
logic prevData;
logic [1:0] smooth_counter = 2'b00;
logic smoothening_finished;
logic sharpening_stall = 1'b1;
logic addition_stall = 1'b1;
logic normalization_stall = 1'b1;
logic [7:0] temp_out [8:0];
logic [12:0]address_read;
logic signed [29:0]normalized_img;
logic signed [8:0]smoothened_img[8:0];
logic signed [20:0] sharpened_image;
logic signed [20:0] addition_out;
logic [8:0] add_img;
//Calling UART Reciver for recieving
Receiver Inst1(

    clk,  //input clock
    reset,  //input reset 
    RxD,  //input receving data line
    RxData,  // output for 8 bits data
    isNewData  //changes value 
);

//Calling UART Sender for Sending 
Sender Inst2(
    clk, //input clock
    reset,//input reset
    TxD, //output data line
    doTransmit, //input signal for start transmitting
    TxData, //input 8 bit data
    isBusy //currently port is busy
);

//Block Ram


BRAM_Controler Inst5(Recieve,address_read,reset,RxData, clk,isNewData,TxData);
Normalization nr1(addition_out,normalized_img, clk ,reset,stall_update);
Smoothening sm1(temp_out,smoothened_img, clk, reset,stall, stall_update);
addition ad1(reset,add_img,stall_update,clk,sharpened_image,addition_out);
sharpening ar1(reset,clk,stall_update,smoothened_img,fil, sharpened_img);
controller cr1(clk, reset, done, stall, address, data_in_pp,temp_out, stall_update, add_img);


//logic for transmission
always_ff@(posedge clk)begin
    if(reset)begin
        address=0;
        doTransmit=0;
    end
    else begin
        if(Transmitt)begin
            if(isBusy)begin
                //do nothing
                doTransmit=0;
            end 
            else begin
                doTransmit=1;
                address=address+1;
            end
        end
        else begin
            doTransmit=0;
        end
    end
end




endmodule