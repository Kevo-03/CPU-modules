`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:42:14 04/20/2024 
// Design Name: 
// Module Name:    AGU 
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
module AGU(
    input clk,               
    input rst,            
    input enable,           
    input [63:0] start_address, 
    input [63:0] generate_size,     
    output reg [63:0] generated_address 
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        generated_address <= start_address;
    end else if (enable) begin
        generated_address <= generated_address + generate_size;
    end
end

endmodule

