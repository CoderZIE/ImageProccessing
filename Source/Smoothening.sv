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



module Smoothening(image,out_final_tt, clk, reset,stall, stall_master);

input [7:0] image [8:0]; //8 bit input image.At one time filter will take 9 values and we are calculating 2 pixel at a time.
input stall;
input clk;
input reset;
output logic stall_master;
output logic signed [8:0]out_final_tt [8:0];
logic signed[7:0]out_final [8:0];

logic [width:0]out;
logic [width:0]temp;
logic [width:0]temp_out;
logic hell;


logic [1:0]register_index_one;
logic [1:0]register_index_two;
logic [1:0]register_index_three;


//Variables for defining the current row and column
int i;
int j;


logic [3:0] GlobalCount; //Global count from 0-15

typedef enum {idle, wait_read, Global_sender, Global_sender_top} states;
typedef enum {get_values, send_values, first_row_sender, row_sender} Lstates;

//State Machine to manage the output of the smoohening
states GlobalState;
Lstates LocalState;

//Temporary Array for storing first two rows
logic [7:0]register[129:0][3:0];
logic [3:0]count;
logic done;


assign stall_master = hell | stall;

assign out_final_tt[0] = {1'b0, out_final[0]}; // Cast 'b0 to match signedness
assign out_final_tt[1] = {1'b0, out_final[1]}; // Similarly for other assignments
assign out_final_tt[2] = {1'b0, out_final[2]};
assign out_final_tt[3] = {1'b0, out_final[3]};
assign out_final_tt[4] = {1'b0, out_final[4]};
assign out_final_tt[5] = {1'b0, out_final[5]};
assign out_final_tt[6] = {1'b0, out_final[6]};
assign out_final_tt[7] = {1'b0, out_final[7]};
assign out_final_tt[8] = {1'b0, out_final[8]};


always_ff @(posedge clk)begin
    if(reset)begin
            temp=0;
            temp_out=0;   
    end
    
    else begin
        if (stall) begin
            temp=temp;    
            temp_out = temp_out; 
        end   
        else begin
            temp=0;
            for(j=0; j<9; j=j+1)begin
                temp[i] = temp[i]+ image[j];
            end
            temp_out= temp/9;
        end
    end
    
end

assign    out = temp_out;


always_ff @(posedge clk)begin

if(reset)begin
register_index_one = 0;
register_index_two = 1;
register_index_three = 2;
count = 0;
GlobalState = idle;
hell = 1;
i =0;
j =0;
done = 0;
GlobalCount = 0;
end

else begin

    case(GlobalState)
    
    
        idle:begin
        
            if(stall)begin
                //do nothing
            end             
            
            else begin
                if(done)begin
                if(i==1 && j > 1)begin
                    out_final [0] =  register[j][register_index_one];
                    out_final [1] =  register[j+ 1][register_index_one];
                    out_final [2] =  register[j + 2][register_index_one];
                    out_final [3] =  register[j][register_index_two];
                    out_final [4] =  register[j + 1][register_index_two];
                    out_final [5] =  register[j + 2][register_index_two];
                    out_final [6] =  register[j][register_index_three];
                    out_final [7] =  register[j+1][register_index_three];
                    out_final [8] =  register[j+2][register_index_three];
                    hell = 0;
                end
                    if(i == 0)begin
                        register[j+1][i]= out;
                    end
                    if(j == 0)begin
                        register[j][i]= out;
                    end
                    register[j+1][i+1]= out;
                        if(j == 126)begin
                        register[j+2][i+1]= out;
                        if(i == 0)begin
                            register[j+1][i]= out;
                        end
                        if(i == 2)begin
                            register_index_one = register_index_one+1;
                            register_index_two = register_index_two+1;
                            register_index_three = register_index_three + 1;
                            GlobalState =  Global_sender;
                            i = 0;
                            j = 0;
                        end else begin
                            i = i + 1;
                            j = 0;
                        end
                    end else begin
                    j = j + 1;
                    end
                    
                end
                done = done + 1;
            end
            
        end   
        
        Global_sender:begin
                            hell = 1;
                            
                            if(GlobalCount==1)begin
                                out_final [0] =  register[j][register_index_one];
                                out_final [1] =  register[j+ 1][register_index_one];
                                out_final [2] =  register[j + 2][register_index_one];
                                out_final [3] =  register[j][register_index_two];
                                out_final [4] =  register[j + 1][register_index_two];
                                out_final [5] =  register[j + 2][register_index_two];
                            end else if(GlobalCount == 2)begin
                                out_final [6] =  out;
                                out_final [7] =  out;
                                register[j][register_index_three] = out;
                                register[j+1][register_index_three] = out;
                                                     
                            end else if(GlobalCount == 3)begin
                                out_final [8] =  out;
                                register[j+2][register_index_three] = out;
                                j=j+1;
                                GlobalState = wait_read;         
                            end                        
                        end
        
        
        wait_read:begin     
                        hell = 0;
                        out_final [0] =   register[j][i];
                        out_final [0] =  register[j][register_index_one];
                        out_final [1] =  register[j+ 1][register_index_one];
                        out_final [2] =  register[j + 2][register_index_one];
                        out_final [3] =  register[j][register_index_two];
                        out_final [4] =  register[j + 1][register_index_two];
                        out_final [5] =  register[j + 2][register_index_two];
                        out_final [6] =  register[j][register_index_three];
                        out_final [7] =  register[j+1][register_index_three];
                        out_final [8] =  register[j+2][register_index_three];
                        register[j+2][register_index_three] = out;
                        
                        if(j==127)begin
                            register_index_one= register_index_one + 1;
                            register_index_two = register_index_two + 1;
                            register_index_three = register_index_three + 1;
                            GlobalState = Global_sender;
                            LocalState= first_row_sender; 
                            j = 0;
                            if(i== 127)begin
                                hell = 1;
                                GlobalState = idle;
                                LocalState = get_values;
                                i = 0;
                                j = 0;
                                GlobalState = idle;
                                LocalState = get_values;
                            end else begin
                                i = i + 1;
                            end
                        end else begin
                            j =j +1;
                        end
                        
        end

    endcase


end
end





endmodule