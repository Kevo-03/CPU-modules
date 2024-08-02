`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:36:19 04/06/2024
// Design Name:   wallace
// Module Name:   C:/Users/User/Desktop/WT/wallace/wallace_tb.v
// Project Name:  wallace
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: wallace
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module wallace_tb;

	// Outputs
	reg [31:0] a, b;
   wire [63:0]out;
	reg [63:0] test;

	// Instantiate the Unit Under Test (UUT)
	wallace uut (
		a, b, out
	);

	initial begin
		a = 154345;
	b = 23167;
	#10$display("  a=%d\n  b=%d\nout=%d", a, b, out);
  	a = 25;
	b = 25;
	#10$display("  a=%d\n  b=%d\nout=%d", a, b, out);
  	a = 5;
	b = 2;
	#10$display("  a=%d\n  b=%d\nout=%d", a, b, out);
  	a = 154345234;
	b = 322;
	#10$display("  a=%d\n  b=%d\nout=%d", a, b, out);
  	a = 10;
	b = 200000;
	#10$display("  a=%d\n  b=%d\nout=%d", a, b, out);
  	a = 1234;
	b = 10023342;
	#10$display("  a=%d\n  b=%d\nout=%d", a, b, out);
	
	repeat (200) begin
		a = $random;
		b = $random;
		test = a*b;
		#10;
		if(out != test) begin
			$display("ERROR: a=%d, b=%d, expected output=%d, resulting output=%d",a,b,test,out);
		end
		else begin
			$display("SUCCESS: a=%d, b=%d, out=%d",a,b,out);
		end
	end

	end
      
endmodule

