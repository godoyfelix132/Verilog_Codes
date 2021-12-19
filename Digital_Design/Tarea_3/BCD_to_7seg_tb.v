/**************************************************************************************
*	Description
*		This is a BCD to 7 segments 
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		03/07/20
***************************************************************************************/

/*`timescale <time_unit>/<time_precision>*/
`timescale 1ns/1ps

module BCD_to_7seg_tb;

reg [3: 0] bcd_tb;

wire a_tb;
wire b_tb;
wire c_tb;
wire d_tb;
wire e_tb;
wire f_tb;
wire g_tb;


BCD_to_7seg
DUV
(
	// Input Ports
	.bcd(bcd_tb),

	// Output Ports
	.a(a_tb),
	.b(b_tb),
	.c(c_tb),
	.d(d_tb),
	.e(e_tb),
	.f(f_tb),
	.g(g_tb)
);

/*********************************************************/
initial begin
   #0 bcd_tb = 0;
	#10 bcd_tb = 1;
	#10 bcd_tb = 2;
	#10 bcd_tb = 3;
	#10 bcd_tb = 4;
	#10 bcd_tb = 5;
	#10 bcd_tb = 6;
	#10 bcd_tb = 7;
	#10 bcd_tb = 8;
	#10 bcd_tb = 9;
	#10 bcd_tb = 10;
	#10 bcd_tb = 11;
	#10 bcd_tb = 12;
	#10 bcd_tb = 13;
	#10 bcd_tb = 14;
	#10 bcd_tb = 15;
	
end
/*********************************************************/

endmodule
