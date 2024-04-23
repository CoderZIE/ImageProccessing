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


module controller(clk, reset, done_recieving, stall, address_read, data_in,temp_out, stall_update, adder);


//Defining Required Inputs and Outputs
input clk;
input reset;
input stall_update;
input done_recieving; // inputs are stores in BRAM
input [7:0]data_in; //to recieve require data
output logic [8:0]adder;
output logic stall; // to stall the pipline
output logic [12:0]address_read; // to recieve data from BRAM
output logic [7:0] temp_out [8:0];//to transfer data

//Defining Require logics
logic [7:0] temp_buffer[3:0] ;
logic [3:0] GlobalCount; //Global count from 0-15
logic [0:0] MegaCount; //Mega count 
logic [0:0] GigaCount; //Giga count 


//Creating state machine
typedef enum {idle, wait_read, Global_sender, Global_sender_top} states;
typedef enum {get_values, send_values, first_row_sender, row_sender} Lstates;

//Variables for defining the current row and column
int i;
int j;

//Temporary Array for storing first two rows
logic [7:0]register[129:0][3:0]; 
logic [1:0]register_index_one;
logic [1:0]register_index_two;
logic [1:0]register_index_three;


//Initiating state machine
states GlobalState;
Lstates LocalState;

int aashu_zaqi;
int ambika;

always@(posedge clk)begin
    
    if(reset)begin
        aashu_zaqi = 1;
        ambika = 0;
    end else if(stall_update)begin
    
        //do nothing
    
    end else begin
    
        adder = {1'b0,register[aashu_zaqi][ambika]} ;
        
        if(aashu_zaqi == 127)begin
            aashu_zaqi = 0;
            ambika = ambika + 1;    
        end else begin
        
            aashu_zaqi = aashu_zaqi + 1;
        end
        
    end

end

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
        register_index_one = 0;
        register_index_two = 1;
        register_index_three = 2;
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
                                register[j][register_index_one] = data_in;
                                address_read = i*image_width + j + 1;
                            end else if(GlobalCount == 2)begin
                                temp_out [1] =  data_in;
                                register[j + 1][register_index_one] = data_in;
                                address_read = i*image_width + j + 2 ;                        
                            end else if(GlobalCount == 3)begin
                                temp_out [2] =  data_in;
                                register[j + 2][register_index_one] = data_in;
                                address_read = (i+1)*image_width + j;                        
                            end else if(GlobalCount == 4)begin
                                temp_out [3] =  data_in;
                                register[j][register_index_two] = data_in;
                                address_read = (i+1)*image_width + j + 1;            
                            end else if(GlobalCount == 5)begin
                                temp_out [4] =  data_in;
                                register[j+1][register_index_two] = data_in;
                                address_read = (i+1)*image_width + j + 2;            
                            end else if(GlobalCount == 6)begin
                                temp_out [5] =  data_in;
                                register[j+2][register_index_two] = data_in;
                                address_read = (i+2)*image_width + j;            
                            end else if(GlobalCount == 7)begin
                                temp_out [6] =  data_in;
                                register[j][register_index_three] = data_in;
                                address_read = (i+2)*image_width + j + 1;            
                            end else if(GlobalCount == 8)begin
                                temp_out [7] =  data_in;
                                register[j+1][register_index_three] = data_in;
                                address_read = (i+2)*image_width + j + 2;            
                            end  else if(GlobalCount == 9)begin
                                temp_out [8] =  data_in;
                                register[j+2][register_index_three] = data_in;
                                address_read = (i)*image_width + j + 1;
                                LocalState = send_values;         
                            end                        
                        end
                     
                     send_values:begin
                        GlobalCount=0;
                        stall = 0;
                        if(j == image_width - 2)begin
                            i = i + 1;
                            register_index_one= register_index_one + 1;
                            register_index_two = register_index_two + 1;
                            register_index_three = register_index_three + 1;
                            GlobalState = Global_sender;
                            LocalState = first_row_sender;
                            GlobalCount=0;
                            MegaCount=0;
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
                        
                        first_row_sender:begin
                            stall = 1;
                            GlobalCount = GlobalCount + 1;
                            if(GlobalCount==1)begin
                                temp_out [0] =  register[j][register_index_one];
                                temp_out [1] =  register[j+ 1][register_index_one];
                                temp_out [2] =  register[j + 2][register_index_one];
                                temp_out [3] =  register[j][register_index_two];
                                temp_out [4] =  register[j + 1][register_index_two];
                                temp_out [5] =  register[j + 2][register_index_two];
                                address_read = (i+2)*image_width + j + 1;
                            end else if(GlobalCount == 2)begin
                                temp_out [6] =  data_in;
                                temp_out [7] =  data_in;
                                register[j][register_index_three] = data_in;
                                register[j+1][register_index_three] = data_in;
                                address_read = (i+2)*image_width + j + 2 ;                        
                            end else if(GlobalCount == 3)begin
                                temp_out [8] =  data_in;
                                register[j+2][register_index_three] = data_in;
                                address_read = (i+2)*image_width + j + 3;
                                j=j+1;
                                LocalState = row_sender;         
                            end                        
                        end
                     
                     row_sender:begin
                        stall = 0;
                        GlobalCount=0;
                        temp_out [0] =  register[j][register_index_one];
                        temp_out [1] =  register[j+ 1][register_index_one];
                        temp_out [2] =  register[j + 2][register_index_one];
                        temp_out [3] =  register[j][register_index_two];
                        temp_out [4] =  register[j + 1][register_index_two];
                        temp_out [5] =  register[j + 2][register_index_two];
                        temp_out [6] =  register[j][register_index_three];
                        temp_out [7] =  register[j][register_index_three];
                        register[j+2][register_index_three] = data_in;
                        address_read = (i+2)*image_width + j + 1;
                        if(j == image_width - 2)begin
                            if(i== image_height - 2)begin
                                stall = 1;
                                address_read = 0;
                                GlobalCount = 0;
                                GlobalState = idle;
                                LocalState = get_values;
                                i = 0;
                                j = 0;
                                MegaCount = 0;
                                GigaCount=0;
                                register_index_one = 0;
                                register_index_two = 1;
                                register_index_three = 2;
                                GlobalState = idle;
                                LocalState = get_values;
                            end else begin
                                i = i + 1;
                            end
                            register_index_one= register_index_one + 1;
                            register_index_two = register_index_two + 1;
                            register_index_three = register_index_three + 1;
                            GlobalState = Global_sender;
                            LocalState= first_row_sender; 
                            j = 0;
                        end else begin
                        j = j + 1;
                        end
                     end 
                      
 
                  
                    endcase
              end  
                  
                  
         
         
        
        endcase 
    
        
    end
    

end






endmodule
