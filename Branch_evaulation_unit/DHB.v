`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:06:19 04/19/2024 
// Design Name: 
// Module Name:    DHB 
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
module DHB(
	input clk,
  	input rst,
  	input branch_taken,
  	input branch_decision,
    input [63:0] current_pc,
    input [63:0] offset,
    output reg [63:0] next_pc,
  	output reg prediction_success,
  	output reg flush
);
  
  always @(posedge clk or posedge rst) begin
    if(rst) begin
      next_pc <= 64'b0;
      prediction_success <= 1'b0;
      flush <= 1'b0;
    end
    else begin
      if(branch_decision) begin
        next_pc <= current_pc + offset;
      end
      else begin
        next_pc <= current_pc + 4;
      end
      
      if(branch_taken != branch_decision) begin
        flush <= 1'b1;
        prediction_success <= 1'b0;
      end
      else begin
        flush <= 1'b0;
        prediction_success <= 1'b1;
      end
    end
  end
endmodule