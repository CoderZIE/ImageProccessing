`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2024 14:53:15
// Design Name: 
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


module Top_module(Recieve, RxD, TxD, clk, reset, Transmitt,disp1, disp2);

input RxD;
input Recieve; //button to start recieving 
input Transmitt; //button to start transmitting
input clk;
input reset;
output logic [7:0]disp1;
output logic [7:0]disp2;
output logic TxD;


//Internal Variables for Top Module
logic [7:0]RxData;
logic isNewData;
logic doTransmit;
logic isBusy;
logic [7:0]TxData;
logic [12:0]address;
logic prevData;

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

always_ff@(posedge clk)begin
    if(Recieve)begin
        if(prevData!=isNewData)begin
            disp1 = RxData;
            prevData=isNewData;
        end
    end
    if(Transmitt)begin
        disp2 = TxData;
    end
end




endmodule
