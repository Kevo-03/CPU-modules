`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:25:39 04/06/2024 
// Design Name: 
// Module Name:    division 
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
module division(
  input [31:0] dividend,
  input [31:0] divisor,
  output reg [31:0] quotient,
  output reg [31:0] remainder
    );
reg [31:0] M;
  reg [63:0] AQ;
  integer i = 0;
  always @* begin
 
  
    if(divisor > dividend) begin
      quotient = 32'd0;
      remainder = dividend;
    end
    
    else begin
    for(i = 0; i < 32; i = i+1) begin
      if(i == 0) begin
         M = divisor;
         AQ [31:0] = dividend;
         AQ [63:32] = 32'd0;	
      end
        
      AQ = AQ << 1;
      AQ[63:32] = AQ[63:32] - M;
      if(AQ[63]) begin
        AQ[0] = 0;
        AQ[63:32] = AQ[63:32] + M;
      end
      else begin
        AQ[0] = 1;
      end
    end
      if(AQ[31]) begin
        quotient = 32'd1;
        remainder = ~(divisor - dividend) + 1;
      end
      else begin
        quotient = AQ[31:0];
        remainder = AQ[63:32];
      end
    end
  
  
  end  


endmodule
