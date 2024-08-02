`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:34:29 04/06/2024 
// Design Name: 
// Module Name:    wallace 
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

module wallace(
input [31:0] a,
	input [31:0] b,
	output [63:0] out
    );

reg [63:0] p_prods [31:0];
	integer i;
	
	always @(a or b)
	begin
		for(i=0; i<32; i=i+1)begin
			if(b[i] == 1)begin
				p_prods[i] <= a << i;
			end
			else
				p_prods[i] = 64'h00000000;
		end
	end

	
	//partial_products pp (a, b, p_prods);

	/*
		The naming convention for the carry save adder modules is: 'l' stands for level
		the first digit after level stands the level in the wallace tree multiplication
		the rest of the digits is an id for the module number in that level.

		For eg: l23 stands for the 3rd carry save adder in level 2.

		u and v stand for the sum and carry outputs of the carry save adder.
	*/

	//The following is for level 1 of wallace tree
	wire [63:0] u_l11, v_l11, u_l12, v_l12, u_l13, v_l13, u_l14, v_l14, u_l15, v_l15, u_l16, v_l16, u_l17, v_l17, u_l18, v_l18, u_l19, v_l19, u_l110, v_l110;

	FA l11 (p_prods[0][63:0], p_prods[1][63:0], p_prods[2][63:0], u_l11[63:0], v_l11[63:0]);
	FA l12 (p_prods[3][63:0], p_prods[4][63:0], p_prods[5][63:0], u_l12[63:0], v_l12[63:0]);
	FA l13 (p_prods[6][63:0], p_prods[7][63:0], p_prods[8][63:0], u_l13[63:0], v_l13[63:0]);
	FA l14 (p_prods[9][63:0], p_prods[10][63:0], p_prods[11][63:0], u_l14[63:0], v_l14[63:0]);
	FA l15 (p_prods[12][63:0], p_prods[13][63:0], p_prods[14][63:0], u_l15[63:0], v_l15[63:0]);
	FA l16 (p_prods[15][63:0], p_prods[16][63:0], p_prods[17][63:0], u_l16[63:0], v_l16[63:0]);
	FA l17 (p_prods[18][63:0], p_prods[19][63:0], p_prods[20][63:0], u_l17[63:0], v_l17[63:0]);
	FA l18 (p_prods[21][63:0], p_prods[22][63:0], p_prods[23][63:0], u_l18[63:0], v_l18[63:0]);
	FA l19 (p_prods[24][63:0], p_prods[25][63:0], p_prods[26][63:0], u_l19[63:0], v_l19[63:0]);
	FA l110 (p_prods[27][63:0], p_prods[28][63:0], p_prods[29][63:0], u_l110[63:0], v_l110[63:0]);
	
	//The following is for level 2 of wallace tree
	wire [63:0] u_l21, v_l21, u_l22, v_l22, u_l23, v_l23, u_l24, v_l24, u_l25, v_l25, u_l26, v_l26, u_l27, v_l27;

	FA l21 (u_l11[63:0], v_l11[63:0], u_l12[63:0], u_l21[63:0], v_l21[63:0]);
	FA l22 (v_l12[63:0], u_l13[63:0], v_l13[63:0], u_l22[63:0], v_l22[63:0]);
	FA l23 (u_l14[63:0], v_l14[63:0], u_l15[63:0], u_l23[63:0], v_l23[63:0]);
	FA l24 (v_l15[63:0], u_l16[63:0], v_l16[63:0], u_l24[63:0], v_l24[63:0]);
	FA l25 (u_l17[63:0], v_l17[63:0], u_l18[63:0], u_l25[63:0], v_l25[63:0]);
	FA l26 (v_l18[63:0], u_l19[63:0], v_l19[63:0], u_l26[63:0], v_l26[63:0]);
	FA l27 (u_l110[63:0], v_l110[63:0], p_prods[30][63:0], u_l27[63:0], v_l27[63:0]);
	
	//The following is for level 3 of wallace tree
	wire [63:0] u_l31, v_l31, u_l32, v_l32, u_l33, v_l33, u_l34, v_l34, u_l35, v_l35;

	FA l31 (u_l21[63:0], v_l21[63:0], u_l22[63:0], u_l31[63:0], v_l31[63:0]);
	FA l32 (v_l22[63:0], u_l23[63:0], v_l23[63:0], u_l32[63:0], v_l32[63:0]);
	FA l33 (u_l24[63:0], v_l24[63:0], u_l25[63:0], u_l33[63:0], v_l33[63:0]);
	FA l34 (v_l25[63:0], u_l26[63:0], v_l26[63:0], u_l34[63:0], v_l34[63:0]);
	FA l35 (u_l27[63:0], v_l27[63:0], p_prods[31][63:0], u_l35[63:0], v_l35[63:0]);

	// The following is for level 4 of wallace tree
	wire [63:0] u_l41, v_l41, u_l42, v_l42, u_l43, v_l43;

	FA l41 (u_l31[63:0], v_l31[63:0], u_l32[63:0], u_l41[63:0], v_l41[63:0]);
	FA l42 (v_l32[63:0], u_l33[63:0], v_l33[63:0], u_l42[63:0], v_l42[63:0]);
	FA l43 (u_l34[63:0], v_l34[63:0], u_l35[63:0], u_l43[63:0], v_l43[63:0]);
	
	// The following is for level 5 of wallace tree
	wire [63:0] u_l51, v_l51, u_l52, v_l52;

	FA l51 (u_l41[63:0], v_l41[63:0], u_l42[63:0], u_l51[63:0], v_l51[63:0]);
	FA l52 (v_l42[63:0], u_l43[63:0], v_l43[63:0], u_l52[63:0], v_l52[63:0]);

	// The following is for level 6 of wallace tree
	wire [63:0] u_l61, v_l61;

	FA l61 (u_l51[63:0], v_l51[63:0], u_l52[63:0], u_l61[63:0], v_l61[63:0]);
	
	// The following is for level 7 of wallace tree
	wire [63:0] u_l71, v_l71;

	FA l71 (u_l61[63:0], v_l61[63:0], v_l52[63:0], u_l71[63:0], v_l71[63:0]);

	// The following is for level 8 of wallace tree
	wire [63:0] u_l81, v_l81;

	FA l81 (u_l71[63:0], v_l71[63:0], v_l35[63:0], u_l81[63:0], v_l81[63:0]);

	// The following is for level 9 of wallace tree
	wire c;
	
  	ksa_top l91( 1'b0, u_l81[31:0], v_l81[31:0],out[31:0],c);
  	ksa_top l92( c , u_l81[63:32], v_l81[63:32],out[63:32],);

endmodule

/*module partial_products (
	input [31:0]a,
	input [31:0]b,
	output reg [63:0]p_prods[31:0]
);

	integer i;

	always @(a or b)
	begin
		for(i=0; i<32; i=i+1)begin
			if(b[i] == 1)begin
				p_prods[i] <= a << i;
			end
			else
				p_prods[i] = 64'h00000000;
		end
	end

endmodule*/

module FA (
	input [63:0] x,
	input [63:0] y,
	input [63:0] z,
	output [63:0] u,
	output [63:0] v);

assign u = x^y^z;
assign v[0] = 0;
assign v[63:1] = (x&y) | (y&z) | (z&x);

endmodule


/*module ksa_top(
  input  wire        c0,
  input  wire [31:0] i_a,
  input  wire [31:0] i_b,
  output wire [31:0] o_s,
  output wire        o_carry
);

wire [31:0] p1;
wire [31:0] g1;
wire        c1;

wire [30:0] p2;
wire [31:0] g2;
wire        c2;
wire [31:0] ps1;

wire [28:0] p3;
wire [31:0] g3;
wire        c3;
wire [31:0] ps2;

wire [24:0] p4;
wire [31:0] g4;
wire        c4;
wire [31:0] ps3;

wire [16:0] p5;
wire [31:0] g5;
wire        c5;
wire [31:0] ps4;

wire [31:0] p6;
wire [31:0] g6;
wire        c6;

ks_1 s1(c0, i_a, i_b, p1, g1, c1);
ks_2 s2(c1, p1, g1, c2, p2, g2, ps1);
ks_3 s3(c2, p2, g2, ps1, c3, p3, g3, ps2);
ks_4 s4(c3, p3, g3, ps2, c4, p4, g4, ps3);
ks_5 s5(c4, p4, g4, ps3, c5, p5, g5, ps4);
ks_6 s6(c5, p5, g5, ps4, c6, p6, g6);
ks_7 s7(c6, p6, g6, o_s, o_carry);

endmodule
module ks_7(
  input  wire        i_c0,
  input  wire [31:0] i_pk,
  input  wire [31:0] i_gk,
  output wire [31:0] o_s,
  output wire        o_carry
);

assign o_carry   = i_gk[31];
assign o_s[0]    = i_c0 ^ i_pk[0];
assign o_s[31:1] = i_gk[30:0] ^ i_pk[31:1];

endmodule
module ks_6(
  input  wire        i_c0,
  input  wire [16:0] i_pk,
  input  wire [31:0] i_gk,
  input  wire [31:0] i_p_save,
  output wire        o_c0,
  output wire [31:0] o_pk,
  output wire [31:0] o_gk
);

wire [16:0] gkj;

assign o_c0       = i_c0;
assign o_pk       = i_p_save[31:0];
assign gkj[0]     = i_c0;
assign gkj[16:1]  = i_gk[15:0];
assign o_gk[15:0] = i_gk[15:0];

grey gc_1(gkj[1], i_pk[1], i_gk[16], o_gk[16]);
grey gc_2(gkj[2], i_pk[2], i_gk[17], o_gk[17]);
grey gc_3(gkj[3], i_pk[3], i_gk[18], o_gk[18]);
grey gc_4(gkj[4], i_pk[4], i_gk[19], o_gk[19]);
grey gc_5(gkj[5], i_pk[5], i_gk[20], o_gk[20]);
grey gc_6(gkj[6], i_pk[6], i_gk[21], o_gk[21]);
grey gc_7(gkj[7], i_pk[7], i_gk[22], o_gk[22]);
grey gc_8(gkj[8], i_pk[8], i_gk[23], o_gk[23]);
grey gc_9(gkj[9], i_pk[9], i_gk[24], o_gk[24]);
grey gc_10(gkj[10], i_pk[10], i_gk[25], o_gk[25]);
grey gc_11(gkj[11], i_pk[11], i_gk[26], o_gk[26]);
grey gc_12(gkj[12], i_pk[12], i_gk[27], o_gk[27]);
grey gc_13(gkj[13], i_pk[13], i_gk[28], o_gk[28]);
grey gc_14(gkj[14], i_pk[14], i_gk[29], o_gk[29]);
grey gc_15(gkj[15], i_pk[15], i_gk[30], o_gk[30]);
grey gc_16(gkj[16], i_pk[16], i_gk[31], o_gk[31]);

endmodule
module ks_5(
  input  wire        i_c0,
  input  wire [24:0] i_pk,
  input  wire [31:0] i_gk,
  input  wire [31:0] i_p_save,
  output wire        o_c0,
  output wire [16:0] o_pk,
  output wire [31:0] o_gk,
  output wire [31:0] o_p_save
);

wire [24:0] gkj;
wire [16:0] pkj;

assign o_c0      = i_c0;
assign o_p_save  = i_p_save[31:0];
assign gkj[0]    = i_c0;
assign gkj[24:1] = i_gk[23:0];
assign pkj       = i_pk[16:0];
assign o_gk[6:0] = i_gk[6:0];

grey gc_0(gkj[0], i_pk[0], i_gk[7], o_gk[7]);
grey gc_1(gkj[1], i_pk[1], i_gk[8], o_gk[8]);
grey gc_2(gkj[2], i_pk[2], i_gk[9], o_gk[9]);
grey gc_3(gkj[3], i_pk[3], i_gk[10], o_gk[10]);
grey gc_4(gkj[4], i_pk[4], i_gk[11], o_gk[11]);
grey gc_5(gkj[5], i_pk[5], i_gk[12], o_gk[12]);
grey gc_6(gkj[6], i_pk[6], i_gk[13], o_gk[13]);
grey gc_7(gkj[7], i_pk[7], i_gk[14], o_gk[14]);
black bc_0(pkj[0], gkj[8], i_pk[8], i_gk[15], o_gk[15], o_pk[0]);
black bc_1(pkj[1], gkj[9], i_pk[9], i_gk[16], o_gk[16], o_pk[1]);
black bc_2(pkj[2], gkj[10], i_pk[10], i_gk[17], o_gk[17], o_pk[2]);
black bc_3(pkj[3], gkj[11], i_pk[11], i_gk[18], o_gk[18], o_pk[3]);
black bc_4(pkj[4], gkj[12], i_pk[12], i_gk[19], o_gk[19], o_pk[4]);
black bc_5(pkj[5], gkj[13], i_pk[13], i_gk[20], o_gk[20], o_pk[5]);
black bc_6(pkj[6], gkj[14], i_pk[14], i_gk[21], o_gk[21], o_pk[6]);
black bc_7(pkj[7], gkj[15], i_pk[15], i_gk[22], o_gk[22], o_pk[7]);
black bc_8(pkj[8], gkj[16], i_pk[16], i_gk[23], o_gk[23], o_pk[8]);
black bc_9(pkj[9], gkj[17], i_pk[17], i_gk[24], o_gk[24], o_pk[9]);
black bc_10(pkj[10], gkj[18], i_pk[18], i_gk[25], o_gk[25], o_pk[10]);
black bc_11(pkj[11], gkj[19], i_pk[19], i_gk[26], o_gk[26], o_pk[11]);
black bc_12(pkj[12], gkj[20], i_pk[20], i_gk[27], o_gk[27], o_pk[12]);
black bc_13(pkj[13], gkj[21], i_pk[21], i_gk[28], o_gk[28], o_pk[13]);
black bc_14(pkj[14], gkj[22], i_pk[22], i_gk[29], o_gk[29], o_pk[14]);
black bc_15(pkj[15], gkj[23], i_pk[23], i_gk[30], o_gk[30], o_pk[15]);
black bc_16(pkj[16], gkj[24], i_pk[24], i_gk[31], o_gk[31], o_pk[16]);

endmodule
module ks_4(
  input  wire        i_c0,
  input  wire [28:0] i_pk,
  input  wire [31:0] i_gk,
  input  wire [31:0] i_p_save,
  output wire        o_c0,
  output wire [24:0] o_pk,
  output wire [31:0] o_gk,
  output wire [31:0] o_p_save
);

wire [28:0] gkj;
wire [24:0] pkj;

assign o_c0      = i_c0;
assign o_p_save  = i_p_save[31:0];
assign gkj[0]    = i_c0;
assign gkj[28:1] = i_gk[27:0];
assign pkj       = i_pk[24:0];
assign o_gk[2:0] = i_gk[2:0];

grey gc_0(gkj[0], i_pk[0], i_gk[3], o_gk[3]);
grey gc_1(gkj[1], i_pk[1], i_gk[4], o_gk[4]);
grey gc_2(gkj[2], i_pk[2], i_gk[5], o_gk[5]);
grey gc_3(gkj[3], i_pk[3], i_gk[6], o_gk[6]);
black bc_0(pkj[0], gkj[4], i_pk[4], i_gk[7], o_gk[7], o_pk[0]);
black bc_1(pkj[1], gkj[5], i_pk[5], i_gk[8], o_gk[8], o_pk[1]);
black bc_2(pkj[2], gkj[6], i_pk[6], i_gk[9], o_gk[9], o_pk[2]);
black bc_3(pkj[3], gkj[7], i_pk[7], i_gk[10], o_gk[10], o_pk[3]);
black bc_4(pkj[4], gkj[8], i_pk[8], i_gk[11], o_gk[11], o_pk[4]);
black bc_5(pkj[5], gkj[9], i_pk[9], i_gk[12], o_gk[12], o_pk[5]);
black bc_6(pkj[6], gkj[10], i_pk[10], i_gk[13], o_gk[13], o_pk[6]);
black bc_7(pkj[7], gkj[11], i_pk[11], i_gk[14], o_gk[14], o_pk[7]);
black bc_8(pkj[8], gkj[12], i_pk[12], i_gk[15], o_gk[15], o_pk[8]);
black bc_9(pkj[9], gkj[13], i_pk[13], i_gk[16], o_gk[16], o_pk[9]);
black bc_10(pkj[10], gkj[14], i_pk[14], i_gk[17], o_gk[17], o_pk[10]);
black bc_11(pkj[11], gkj[15], i_pk[15], i_gk[18], o_gk[18], o_pk[11]);
black bc_12(pkj[12], gkj[16], i_pk[16], i_gk[19], o_gk[19], o_pk[12]);
black bc_13(pkj[13], gkj[17], i_pk[17], i_gk[20], o_gk[20], o_pk[13]);
black bc_14(pkj[14], gkj[18], i_pk[18], i_gk[21], o_gk[21], o_pk[14]);
black bc_15(pkj[15], gkj[19], i_pk[19], i_gk[22], o_gk[22], o_pk[15]);
black bc_16(pkj[16], gkj[20], i_pk[20], i_gk[23], o_gk[23], o_pk[16]);
black bc_17(pkj[17], gkj[21], i_pk[21], i_gk[24], o_gk[24], o_pk[17]);
black bc_18(pkj[18], gkj[22], i_pk[22], i_gk[25], o_gk[25], o_pk[18]);
black bc_19(pkj[19], gkj[23], i_pk[23], i_gk[26], o_gk[26], o_pk[19]);
black bc_20(pkj[20], gkj[24], i_pk[24], i_gk[27], o_gk[27], o_pk[20]);
black bc_21(pkj[21], gkj[25], i_pk[25], i_gk[28], o_gk[28], o_pk[21]);
black bc_22(pkj[22], gkj[26], i_pk[26], i_gk[29], o_gk[29], o_pk[22]);
black bc_23(pkj[23], gkj[27], i_pk[27], i_gk[30], o_gk[30], o_pk[23]);
black bc_24(pkj[24], gkj[28], i_pk[28], i_gk[31], o_gk[31], o_pk[24]);

endmodule
module ks_3(
  input  wire        i_c0,
  input  wire [30:0] i_pk,
  input  wire [31:0] i_gk,
  input  wire [31:0] i_p_save,
  output wire        o_c0,
  output wire [28:0] o_pk,
  output wire [31:0] o_gk,
  output wire [31:0] o_p_save
);

wire [30:0] gkj;
wire [28:0] pkj;

assign o_c0      = i_c0;
assign o_p_save  = i_p_save[31:0];
assign gkj[0]    = i_c0;
assign gkj[30:1] = i_gk[29:0];
assign pkj       = i_pk[28:0];
assign o_gk[0]   = i_gk[0];

grey gc_0(gkj[0], i_pk[0], i_gk[1], o_gk[1]);
grey gc_1(gkj[1], i_pk[1], i_gk[2], o_gk[2]);
black bc_0(pkj[0], gkj[2], i_pk[2], i_gk[3], o_gk[3], o_pk[0]);
black bc_1(pkj[1], gkj[3], i_pk[3], i_gk[4], o_gk[4], o_pk[1]);
black bc_2(pkj[2], gkj[4], i_pk[4], i_gk[5], o_gk[5], o_pk[2]);
black bc_3(pkj[3], gkj[5], i_pk[5], i_gk[6], o_gk[6], o_pk[3]);
black bc_4(pkj[4], gkj[6], i_pk[6], i_gk[7], o_gk[7], o_pk[4]);
black bc_5(pkj[5], gkj[7], i_pk[7], i_gk[8], o_gk[8], o_pk[5]);
black bc_6(pkj[6], gkj[8], i_pk[8], i_gk[9], o_gk[9], o_pk[6]);
black bc_7(pkj[7], gkj[9], i_pk[9], i_gk[10], o_gk[10], o_pk[7]);
black bc_8(pkj[8], gkj[10], i_pk[10], i_gk[11], o_gk[11], o_pk[8]);
black bc_9(pkj[9], gkj[11], i_pk[11], i_gk[12], o_gk[12], o_pk[9]);
black bc_10(pkj[10], gkj[12], i_pk[12], i_gk[13], o_gk[13], o_pk[10]);
black bc_11(pkj[11], gkj[13], i_pk[13], i_gk[14], o_gk[14], o_pk[11]);
black bc_12(pkj[12], gkj[14], i_pk[14], i_gk[15], o_gk[15], o_pk[12]);
black bc_13(pkj[13], gkj[15], i_pk[15], i_gk[16], o_gk[16], o_pk[13]);
black bc_14(pkj[14], gkj[16], i_pk[16], i_gk[17], o_gk[17], o_pk[14]);
black bc_15(pkj[15], gkj[17], i_pk[17], i_gk[18], o_gk[18], o_pk[15]);
black bc_16(pkj[16], gkj[18], i_pk[18], i_gk[19], o_gk[19], o_pk[16]);
black bc_17(pkj[17], gkj[19], i_pk[19], i_gk[20], o_gk[20], o_pk[17]);
black bc_18(pkj[18], gkj[20], i_pk[20], i_gk[21], o_gk[21], o_pk[18]);
black bc_19(pkj[19], gkj[21], i_pk[21], i_gk[22], o_gk[22], o_pk[19]);
black bc_20(pkj[20], gkj[22], i_pk[22], i_gk[23], o_gk[23], o_pk[20]);
black bc_21(pkj[21], gkj[23], i_pk[23], i_gk[24], o_gk[24], o_pk[21]);
black bc_22(pkj[22], gkj[24], i_pk[24], i_gk[25], o_gk[25], o_pk[22]);
black bc_23(pkj[23], gkj[25], i_pk[25], i_gk[26], o_gk[26], o_pk[23]);
black bc_24(pkj[24], gkj[26], i_pk[26], i_gk[27], o_gk[27], o_pk[24]);
black bc_25(pkj[25], gkj[27], i_pk[27], i_gk[28], o_gk[28], o_pk[25]);
black bc_26(pkj[26], gkj[28], i_pk[28], i_gk[29], o_gk[29], o_pk[26]);
black bc_27(pkj[27], gkj[29], i_pk[29], i_gk[30], o_gk[30], o_pk[27]);
black bc_28(pkj[28], gkj[30], i_pk[30], i_gk[31], o_gk[31], o_pk[28]);

endmodule
module ks_2(
  input  wire        i_c0,
  input  wire [31:0] i_pk,
  input  wire [31:0] i_gk,
  output wire        o_c0,
  output wire [30:0] o_pk,
  output wire [31:0] o_gk,
  output wire [31:0] o_p_save
);

wire [31:0] gkj;
wire [30:0] pkj;

assign o_c0      = i_c0;
assign o_p_save  = i_pk[31:0];
assign gkj[0]    = i_c0;
assign gkj[31:1] = i_gk[30:0];
assign pkj       = i_pk[30:0];

grey gc_0(gkj[0], i_pk[0], i_gk[0], o_gk[0]);
black bc_0(pkj[0], gkj[1], i_pk[1], i_gk[1], o_gk[1], o_pk[0]);
black bc_1(pkj[1], gkj[2], i_pk[2], i_gk[2], o_gk[2], o_pk[1]);
black bc_2(pkj[2], gkj[3], i_pk[3], i_gk[3], o_gk[3], o_pk[2]);
black bc_3(pkj[3], gkj[4], i_pk[4], i_gk[4], o_gk[4], o_pk[3]);
black bc_4(pkj[4], gkj[5], i_pk[5], i_gk[5], o_gk[5], o_pk[4]);
black bc_5(pkj[5], gkj[6], i_pk[6], i_gk[6], o_gk[6], o_pk[5]);
black bc_6(pkj[6], gkj[7], i_pk[7], i_gk[7], o_gk[7], o_pk[6]);
black bc_7(pkj[7], gkj[8], i_pk[8], i_gk[8], o_gk[8], o_pk[7]);
black bc_8(pkj[8], gkj[9], i_pk[9], i_gk[9], o_gk[9], o_pk[8]);
black bc_9(pkj[9], gkj[10], i_pk[10], i_gk[10], o_gk[10], o_pk[9]);
black bc_10(pkj[10], gkj[11], i_pk[11], i_gk[11], o_gk[11], o_pk[10]);
black bc_11(pkj[11], gkj[12], i_pk[12], i_gk[12], o_gk[12], o_pk[11]);
black bc_12(pkj[12], gkj[13], i_pk[13], i_gk[13], o_gk[13], o_pk[12]);
black bc_13(pkj[13], gkj[14], i_pk[14], i_gk[14], o_gk[14], o_pk[13]);
black bc_14(pkj[14], gkj[15], i_pk[15], i_gk[15], o_gk[15], o_pk[14]);
black bc_15(pkj[15], gkj[16], i_pk[16], i_gk[16], o_gk[16], o_pk[15]);
black bc_16(pkj[16], gkj[17], i_pk[17], i_gk[17], o_gk[17], o_pk[16]);
black bc_17(pkj[17], gkj[18], i_pk[18], i_gk[18], o_gk[18], o_pk[17]);
black bc_18(pkj[18], gkj[19], i_pk[19], i_gk[19], o_gk[19], o_pk[18]);
black bc_19(pkj[19], gkj[20], i_pk[20], i_gk[20], o_gk[20], o_pk[19]);
black bc_20(pkj[20], gkj[21], i_pk[21], i_gk[21], o_gk[21], o_pk[20]);
black bc_21(pkj[21], gkj[22], i_pk[22], i_gk[22], o_gk[22], o_pk[21]);
black bc_22(pkj[22], gkj[23], i_pk[23], i_gk[23], o_gk[23], o_pk[22]);
black bc_23(pkj[23], gkj[24], i_pk[24], i_gk[24], o_gk[24], o_pk[23]);
black bc_24(pkj[24], gkj[25], i_pk[25], i_gk[25], o_gk[25], o_pk[24]);
black bc_25(pkj[25], gkj[26], i_pk[26], i_gk[26], o_gk[26], o_pk[25]);
black bc_26(pkj[26], gkj[27], i_pk[27], i_gk[27], o_gk[27], o_pk[26]);
black bc_27(pkj[27], gkj[28], i_pk[28], i_gk[28], o_gk[28], o_pk[27]);
black bc_28(pkj[28], gkj[29], i_pk[29], i_gk[29], o_gk[29], o_pk[28]);
black bc_29(pkj[29], gkj[30], i_pk[30], i_gk[30], o_gk[30], o_pk[29]);
black bc_30(pkj[30], gkj[31], i_pk[31], i_gk[31], o_gk[31], o_pk[30]);

endmodule
module ks_1(
  input wire i_c0,
  input  wire [31:0]i_a,
  input  wire [31:0]i_b,
  output wire [31:0]o_pk_1,
  output wire [31:0]o_gk_1,
  output o_c0_1
);

assign o_c0_1 = i_c0;

pg pg_0(i_a[0], i_b[0], o_pk_1[0], o_gk_1[0]);
pg pg_1(i_a[1], i_b[1], o_pk_1[1], o_gk_1[1]);
pg pg_2(i_a[2], i_b[2], o_pk_1[2], o_gk_1[2]);
pg pg_3(i_a[3], i_b[3], o_pk_1[3], o_gk_1[3]);
pg pg_4(i_a[4], i_b[4], o_pk_1[4], o_gk_1[4]);
pg pg_5(i_a[5], i_b[5], o_pk_1[5], o_gk_1[5]);
pg pg_6(i_a[6], i_b[6], o_pk_1[6], o_gk_1[6]);
pg pg_7(i_a[7], i_b[7], o_pk_1[7], o_gk_1[7]);
pg pg_8(i_a[8], i_b[8], o_pk_1[8], o_gk_1[8]);
pg pg_9(i_a[9], i_b[9], o_pk_1[9], o_gk_1[9]);
pg pg_10(i_a[10], i_b[10], o_pk_1[10], o_gk_1[10]);
pg pg_11(i_a[11], i_b[11], o_pk_1[11], o_gk_1[11]);
pg pg_12(i_a[12], i_b[12], o_pk_1[12], o_gk_1[12]);
pg pg_13(i_a[13], i_b[13], o_pk_1[13], o_gk_1[13]);
pg pg_14(i_a[14], i_b[14], o_pk_1[14], o_gk_1[14]);
pg pg_15(i_a[15], i_b[15], o_pk_1[15], o_gk_1[15]);
pg pg_16(i_a[16], i_b[16], o_pk_1[16], o_gk_1[16]);
pg pg_17(i_a[17], i_b[17], o_pk_1[17], o_gk_1[17]);
pg pg_18(i_a[18], i_b[18], o_pk_1[18], o_gk_1[18]);
pg pg_19(i_a[19], i_b[19], o_pk_1[19], o_gk_1[19]);
pg pg_20(i_a[20], i_b[20], o_pk_1[20], o_gk_1[20]);
pg pg_21(i_a[21], i_b[21], o_pk_1[21], o_gk_1[21]);
pg pg_22(i_a[22], i_b[22], o_pk_1[22], o_gk_1[22]);
pg pg_23(i_a[23], i_b[23], o_pk_1[23], o_gk_1[23]);
pg pg_24(i_a[24], i_b[24], o_pk_1[24], o_gk_1[24]);
pg pg_25(i_a[25], i_b[25], o_pk_1[25], o_gk_1[25]);
pg pg_26(i_a[26], i_b[26], o_pk_1[26], o_gk_1[26]);
pg pg_27(i_a[27], i_b[27], o_pk_1[27], o_gk_1[27]);
pg pg_28(i_a[28], i_b[28], o_pk_1[28], o_gk_1[28]);
pg pg_29(i_a[29], i_b[29], o_pk_1[29], o_gk_1[29]);
pg pg_30(i_a[30], i_b[30], o_pk_1[30], o_gk_1[30]);
pg pg_31(i_a[31], i_b[31], o_pk_1[31], o_gk_1[31]);

endmodule
module grey(
  input  wire i_gj,
  input  wire i_pk,
  input  wire i_gk,
  output wire o_g
);

assign o_g = i_gk | (i_gj & i_pk);

endmodule
module black(
  input  wire i_pj,
  input  wire i_gj,
  input  wire i_pk,
  input  wire i_gk,
  output wire o_g,
  output wire o_p
);

assign o_g = i_gk | (i_gj & i_pk);
assign o_p = i_pk & i_pj;

endmodule
module pg(
  input  wire i_a,
  input  wire i_b,
  output wire o_p,
  output wire o_g
);

assign o_p = i_a ^ i_b;
assign o_g = i_a & i_b;

endmodule*/

