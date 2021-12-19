/**************************************************************************************
*	Description
*		This is a 2 to 1 multiplexer that can be parameterized in it's bit-width.
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		24/07/20
***************************************************************************************/

module Mux_Two_To_One
#(
	parameter N_BITS = 8
)
(
	// Input Ports
	input [N_BITS-1 : 0] Selector,
	input [N_BITS-1 : 0] Data_0,
	input [N_BITS-1 : 0] Data_1,
	
	// Output Ports
	output [N_BITS-1 : 0] Mux_Output

);


wire [N_BITS-1 : 0] Not_Selector_wire;

wire [N_BITS-1 : 0] And_Data_0_Not_Selector_wire;

wire [N_BITS-1 : 0] And_Data_1_Selector_wire;

wire [N_BITS-1 : 0] Or_Multiplexer_wire;

Not_Gate
#(
	.N_BITS(N_BITS)
)
This_is_a_Not_Gate
(
	// Input Ports
	.A(Selector),
	
	// Output Ports
	.B(Not_Selector_wire)

);


And_Gate
#(
	.N_BITS(N_BITS)
)
This_is_an_AND_Gate_1
(
	// Input Ports
	.A(Not_Selector_wire),
	.B(Data_0),
	
	// Output Ports
	.C(And_Data_0_Not_Selector_wire)

);

And_Gate
#(
	.N_BITS(N_BITS)
)
This_is_an_AND_Gate_2
(
	// Input Ports
	.A(Selector),
	.B(Data_1),
	
	// Output Ports
	.C(And_Data_1_Selector_wire)

);

Or_Gate
#(
	.N_BITS(N_BITS)
)
This_is_a_Or_Gate
(
	// Input Ports
	.A(And_Data_0_Not_Selector_wire),
	.B(And_Data_1_Selector_wire),
	
	// Output Ports
	.C(Or_Multiplexer_wire)

);

assign Mux_Output = Or_Multiplexer_wire;


endmodule




