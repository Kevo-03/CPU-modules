`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:02:58 04/21/2024 
// Design Name: 
// Module Name:    ALU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "ksa_top.v"

module ALU(
  input [31:0] in1,
  input [31:0] in2,
  input [2:0] op,
  output reg [31:0] out
);
  wire cin,cout;
  wire [31:0] sum,sub;
  assign cin = 1'b0;
  ksa_top adder ( cin,in1,in2,sum,cout);
  ksa_top substractor (cin,in1,((~in2)+1),sub,cout);
  always @* begin
    case(op)
       3'b000 : out = sum;
       3'b001 : out = sub;
       3'b010 : out = in1 << in2;
       3'b011 : out = in1 >> in2;
       3'b100 : out = in1 >>> in2;
       3'b101 : out = in1 & in2;
       3'b110 : out = in1 | in2;
       3'b111 : out = in1 ^ in2;
    endcase
  end
  
endmodule
    
