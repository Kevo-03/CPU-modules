`timescale 1ns / 1ps

module AGU_tb;

    
    reg clk;
    reg rst;
    reg enable;
    reg [63:0] start_address;
    reg [63:0] generate_size;

    wire [63:0] generated_address;

    
    AGU uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .start_address(start_address),
        .generate_size(generate_size),
        .generated_address(generated_address)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  
    end

   
    initial begin
        
        rst = 1; enable = 0; start_address = 0; generate_size = 0;
        #10;  
		  
        rst = 0; start_address = 64'd100; generate_size = 64'd10;
        #10;  

        enable = 1;
        #50;  

        enable = 0;
        rst = 1;
        #10;

        rst = 0; start_address = 64'd200; generate_size = 64'd20;
        enable = 1;
        #50; 

        
        $finish;
    end

    
    initial begin
        $monitor("At time %t, generated_address = %b", $time, generated_address);
    end

endmodule
