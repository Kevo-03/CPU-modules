`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:06:09 04/21/2024
// Design Name:   ALU
// Module Name:   C:/Users/User/Desktop/ALU/ALU/ALU_tb.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_tb;
  reg [31:0] in1,in2;
  reg [2:0] op;
  wire [31:0] out;
  
  ALU alu (in1,in2,op,out);
  
  initial begin
    in1 = 32'd154345;
    in2 = 32'd23167;
    op = 3'd0;
    #10$display("  in1=%d\n  in2=%d\n  out=%d", in1, in2, out);
    in1 = 32'd154345;
    in2 = 32'd23167;
    op = 3'd1;
    #10$display("  in1=%d\n  in2=%d\n  out=%d", in1, in2, out);
    in1 = 32'd567;
    in2 = 32'd2;
    op = 3'd2;
    #10$display("  in1=%d\n  in2=%d\n  out=%d", in1, in2, out);
    in1 = 32'd567;
    in2 = 32'd2;
    op = 3'd3;
    #10$display("  in1=%d\n  in2=%d\n  out=%d", in1, in2, out);
    in1 = 32'd567;
    in2 = 32'd2;
    op = 3'd4;
    #10$display("  in1=%d\n  in2=%d\n  out=%d", in1, in2, out);
    in1 = 32'b00011011000010111101000011101011;
    in2 = 32'b11011111101110100000110011111110;;
    op = 3'd5;
    #10$display("  in1=%b\n  in2=%b\n  out=%b", in1, in2, out);
    in1 = 32'b00011011000010111101000011101011;
    in2 = 32'b11011111101110100000110011111110;;
    op = 3'd6;
    #10$display("  in1=%b\n  in2=%b\n  out=%b", in1, in2, out);
    in1 = 32'b00011011000010111101000011101011;
    in2 = 32'b11011111101110100000110011111110;;
    op = 3'd7;
    #10$display("  in1=%b\n  in2=%b\n  out=%b", in1, in2, out);
  end
endmodule