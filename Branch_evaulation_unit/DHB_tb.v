`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:07:10 04/19/2024
// Design Name:   DHB
// Module Name:   C:/Users/User/Desktop/DHB/DHB/DHB_tb.v
// Project Name:  DHB
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DHB
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DHB_tb;
   
    reg clk;
    reg rst;
    reg branch_taken;
    reg branch_decision;
    reg [63:0] current_pc;
    reg [63:0] offset;

   
    wire [63:0] next_pc;
    wire prediction_success;
    wire flush;

    
    DHB uut (
        .clk(clk),
        .rst(rst),
        .branch_taken(branch_taken),
        .branch_decision(branch_decision),
        .current_pc(current_pc),
        .offset(offset),
        .next_pc(next_pc),
        .prediction_success(prediction_success),
        .flush(flush)
    );

   
    always #10 clk = ~clk;

   
    initial begin
       
        clk = 0;
        rst = 1;
        branch_taken = 0;
        branch_decision = 0;
        current_pc = 0;
        offset = 0;

       
        #100;
        
        
        rst = 0;
        current_pc = 64'h1000;
        offset = 64'h16;
        
       
        #20; 
        branch_taken = 0;
        branch_decision = 0;
        #20; 
       $display("Time: %t, next_pc: %h, prediction_success: %b, flush: %b", $time, next_pc, prediction_success, flush);

      
        current_pc = next_pc;
        branch_taken = 1;
        branch_decision = 1;
        #20; 
       $display("Time: %t, next_pc: %h, prediction_success: %b, flush: %b", $time, next_pc, prediction_success, flush);

      
        current_pc = next_pc;
        branch_taken = 1;
        branch_decision = 0;
        #20; 

       
        $display("Time: %t, next_pc: %h, prediction_success: %b, flush: %b", $time, next_pc, prediction_success, flush);

        
        $finish;
    end
endmodule