`timescale 1ns / 1ps

module sharpening_tb();

    logic clk;
    logic [8:0] img [0:2][0:2];
    logic signed [7:0] fil [0:2][0:2];
    logic signed [16:0] out;

    sharpening sh1(
        .clk(clk),
        .img(img),
        .fil(fil),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus generation
    initial begin
        // Define filter and image values
       fil = '{'{0,-1,0}, {-1,5,-1}, {0,-1,0}};
       img = '{'{2,0,0}, {5,255,0}, {1,2,4}};

        // Wait for initial setup
        #10;
    end

endmodule