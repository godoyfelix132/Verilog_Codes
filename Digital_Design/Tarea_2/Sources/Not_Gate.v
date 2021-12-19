/**************************************************************************************
*	Description
*		This is a NOT gate that can be parameterized in it's bit-width.
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		26/06/20
***************************************************************************************/

module Not_Gate
#(
	parameter N_BITS = 8
)
(
	// Input Ports
	input [N_BITS-1 : 0] A,
	
	// Output Ports
	output [N_BITS-1 : 0] B

);

assign B = ~A;

endmodule
