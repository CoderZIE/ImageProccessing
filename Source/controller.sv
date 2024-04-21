`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  NANODC LAB
// Engineer: 
// 
// Create Date: 18.04.2024 13:52:40
// Design Name: 
// Module Name: controller
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

parameter image_height = 130;
parameter image_width  =  130;


module controller(clk, reset, done_recieving, stall, address_read, data_in,temp_out);


//Defining Required Inputs and Outputs
input clk;
input reset;
input done_recieving; // inputs are stores in BRAM
input [7:0]data_in; //to recieve require data
output logic stall; // to stall the pipline
output logic [12:0]address_read; // to recieve data from BRAM
output logic [7:0] temp_out [8:0];//to transfer data

//Defining Require logics
logic [7:0] temp_buffer[3:0] ;
logic [3:0] GlobalCount; //Global count from 0-7
logic [0:0] MegaCount; //Mega count 
logic [0:0] GigaCount; //Giga count 


//Creating state machine
typedef enum {idle, wait_read, Global_sender, Global_sender_top} states;
typedef enum {get_values, send_values} Lstates;

//Variables for defining the current row and column
int i;
int j;

//Temporary Array for storing first two rows
logic [7:0]register[389:0]; 


//Initiating state machine
states GlobalState;
Lstates LocalState;


always_ff@(posedge clk)begin

    if(reset)begin
        stall = 1;
        address_read = 0;
        GlobalCount = 0;
        GlobalState = idle;
        LocalState = get_values;
        i = 0;
        j = 0;
        MegaCount = 0;
        GigaCount=0;
    end
    
    else begin
    
        case(GlobalState)
        
        idle: begin    //wait untill the data is stored in BRAM
                if(done_recieving)begin
                    GlobalState = wait_read;
                end           
              end
              
        wait_read:begin  //wait for first four values
                case(LocalState)
                        
                        get_values:begin
                            stall = 1;
                            GlobalCount = GlobalCount + 1;
                            if(GlobalCount==1)begin
                                temp_out [0] =  data_in;
                                register[ i*image_width + j] = data_in;
                                address_read = i*image_width + j + 1;
                            end else if(GlobalCount == 2)begin
                                temp_out [1] =  data_in;
                                register[ i*image_width + j + 1] = data_in;
                                address_read = i*image_width + j + 2 ;                        
                            end else if(GlobalCount == 3)begin
                                temp_out [2] =  data_in;
                                register[ i*image_width + j + 2] = data_in;
                                address_read = (i+1)*image_width + j;                        
                            end else if(GlobalCount == 4)begin
                                temp_out [3] =  data_in;
                                register[ (i+ 1)*image_width + j] = data_in;
                                address_read = (i+1)*image_width + j + 1;            
                            end else if(GlobalCount == 5)begin
                                temp_out [4] =  data_in;
                                register[ (i+1)*image_width + j+ 1] = data_in;
                                address_read = (i+1)*image_width + j + 2;            
                            end else if(GlobalCount == 6)begin
                                temp_out [5] =  data_in;
                                register[ (i+1)*image_width + j + 2] = data_in;
                                address_read = (i+2)*image_width + j;            
                            end else if(GlobalCount == 7)begin
                                temp_out [6] =  data_in;
                                register[ (i+2)*image_width + j] = data_in;
                                address_read = (i+2)*image_width + j + 1;            
                            end else if(GlobalCount == 8)begin
                                temp_out [7] =  data_in;
                                register[ (i+2)*image_width + j + 1] = data_in;
                                address_read = (i+2)*image_width + j + 2;            
                            end  else if(GlobalCount == 9)begin
                                temp_out [8] =  data_in;
                                GlobalCount = 0;
                                register[ (i+2)*image_width + j + 2] = data_in;
                                address_read = (i+3)*image_width + j;
                                LocalState = send_values;         
                            end                        
                        end
                     
                     send_values:begin
                        stall = 0;
                        if(j == image_width - 2)begin
                            i = i + 1;
                            GlobalState = Global_sender;
                            LocalState = get_values;
                            j = 0;
                        end else begin
                            j = j + 1;
                            LocalState = get_values;
                        end
                     end 
                      
 
                  
                    endcase
              end
                  
              Global_sender:begin
                    case(LocalState)
                        
                        get_values:begin
                            stall = 1;
                            GlobalCount = GlobalCount + 1;
                            if(GlobalCount==1)begin
                                temp_out [0] =  register[j];
                                temp_out [1] =  register[j + 1];
                                temp_out [2] =  register[j + 2];
                                temp_out [3] =  register[image_width + j];
                                temp_out [4] =  register[image_width + j + 1];
                                temp_out [5] =  register[image_width + j + 2];
                                address_read = (i+2)*image_width + j + 1;
                            end else if(GlobalCount == 2)begin
                                temp_out [6] =  data_in;
                                temp_out [7] =  data_in;
                                register[ i*image_width + j + 1] = data_in;
                                address_read = (i+2)*image_width + j + 2 ;                        
                            end else if(GlobalCount == 3)begin
                                temp_out [8] =  data_in;
                                register[ (i+2)*image_width + j + 2] = data_in;
                                address_read = (i+1)*image_width + j;
                                LocalState = send_values;         
                            end                        
                        end
                     
                     send_values:begin
                        stall = 0;
                        if(j == image_width - 2)begin
                            i = i + 1;
                            GlobalState = Global_sender;
                            j = 0;
                        end
                        j = j + 1;
                        LocalState = get_values;
                     end 
                      
 
                  
                    endcase
              end  
                  
                  
         
         
        
        endcase 
    
        
    end
    

end






endmodule
