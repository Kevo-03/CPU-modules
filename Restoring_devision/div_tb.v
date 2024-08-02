`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:26:51 04/06/2024
// Design Name:   division
// Module Name:   C:/Users/User/Desktop/RD/div/div_tb.v
// Project Name:  div
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: division
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module div_tb;

	reg [31:0] dividend,divisor;
  wire [31:0] quotient,remainder;
  reg [31:0] expected_quotient, expected_remainder;
  

	// Instantiate the Unit Under Test (UUT)
	division uut (
		dividend,divisor,quotient,remainder
	);

	initial begin
		 dividend = 32'd32;
    divisor = 32'd8;
    #10$display("  dividend=%d\n  divisor=%d\n  quotiend=%d\n  remainder=%d", dividend, divisor, quotient, remainder);
    dividend = 32'd124432;
    divisor = 32'd1226;
    #10$display("  dividend=%d\n  divisor=%d\n  quotiend=%d\n  remainder=%d", dividend, divisor, quotient, remainder);
    dividend = 32'd81;
    divisor = 32'd2;
    #10$display("  dividend=%d\n  divisor=%d\n  quotiend=%d\n  remainder=%d", dividend, divisor, quotient, remainder);
    dividend = 32'd3807872197;
      divisor = 32'd25;
      expected_quotient = dividend / divisor; 
      expected_remainder = dividend % divisor;
      #10; 
       if (quotient != expected_quotient || remainder != expected_remainder) begin
         $display("HATA: dividend=%b, divisor=%b, beklenen quotient=%b, elde edilen quotient=%b, beklenen remainder=%b, elde edilen remainder=%b", 
                dividend, divisor, expected_quotient, quotient, expected_remainder, remainder);
    end else begin
      $display("Test case geçti: dividend=%b, divisor=%b, quotient=%b, remainder=%b", 
                dividend, divisor, quotient, remainder);
    end
    
    repeat (200) begin
      dividend = $random;
      divisor = $random;
      expected_quotient = dividend / divisor; 
      expected_remainder = dividend % divisor;
      #10; 
       if (quotient != expected_quotient || remainder != expected_remainder) begin
         $display("HATA: dividend=%d, divisor=%d, beklenen quotient=%d, elde edilen quotient=%d, beklenen remainder=%d, elde edilen remainder=%d", 
                dividend, divisor, expected_quotient, quotient, expected_remainder, remainder);
    end else begin
      $display("Test case geçti: dividend=%d, divisor=%d, quotient=%d, remainder=%d", 
                dividend, divisor, quotient, remainder);
    end
    end

	end
      
endmodule

