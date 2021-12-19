/**************************************************************************************
*	Description
*		This is an AND gate that can be parameterized in it's bit-width.
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		24/07/20
***************************************************************************************/

module And_Gate
#(
	parameter N_BITS = 8
)
(
	// Input Ports
	input [N_BITS-1 : 0] A,
	input [N_BITS-1 : 0] B,
	
	// Output Ports
	output [N_BITS-1 : 0] C

);

assign C = A & B;

endmodule


