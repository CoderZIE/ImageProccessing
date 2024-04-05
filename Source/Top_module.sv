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


module Top_module(RxD, TxD, clk, reset);

input RxD;
input clk;
input reset;
output logic TxD;


//Internal Variables for Top Module
logic [7:0]RxData;
logic isNewData;
logic doTransmit;
logic isBusy;
logic [7:0]TxData;

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





endmodule
