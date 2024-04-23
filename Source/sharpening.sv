module sharpening(
    input reset,
    input clk,
    input stall,
    input  signed [8:0] img[8:0], //we have taken 9 bit input to handle negative numbers
    input logic signed [7:0] fil[0:2][0:2], 
    output logic signed [20:0] out //as maximum 17+4(as 9 occupy 4 bit) 
);

    logic signed [16:0] temp[0:8];  //multiplication of 9 and 8 bit can occupy maximum 17 bits

    always_ff @(posedge clk) begin
       if(reset) out=0;
       else begin
       if(stall) out=out;
       else begin
        temp[0] = (fil[0][0]) * img[0];
        temp[1] = (fil[0][1]) * img[1];
        temp[2] = (fil[0][2]) * img[2];
        temp[3] = (fil[1][0]) * img[3];
        temp[4] = (fil[1][1]) * img[4];
        temp[5] = (fil[1][2]) * img[5];
        temp[6] = (fil[2][0]) * img[6];
        temp[7] = (fil[2][1]) * img[7];
        temp[8] = (fil[2][2]) * img[8];
        
        out = temp[0] + temp[1] + temp[2] + temp[3] + temp[4] + temp[5] + temp[6] + temp[7] + temp[8];
        end
        end
    end
endmodule