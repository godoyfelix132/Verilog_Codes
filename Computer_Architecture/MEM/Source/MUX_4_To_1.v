/**************************************************************************************
*	Description
*		This is a 8 to 1 multiplexer that can be parameterized in it's bit-width.
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		24/07/20
***************************************************************************************/

module MUX_4_To_1
#(
	parameter N_BITS = 32
)
(
	// Input Ports
	input [1 : 0]Selector,
	input [N_BITS-1 : 0] Data_0,
	input [N_BITS-1 : 0] Data_1,
	input [N_BITS-1 : 0] Data_2,
	input [N_BITS-1 : 0] Data_3,
	
	// Output Ports
	output [N_BITS-1 : 0] Mux_Output

);


wire [N_BITS-1 : 0] Output_Two_Mux_1_wire;
wire [N_BITS-1 : 0] Output_Two_Mux_2_wire;
wire [N_BITS-1 : 0] Output_Two_Mux_1_And_2_wire;
wire [N_BITS-1 : 0] N_Selector_0_wire;
wire [N_BITS-1 : 0] N_Selector_1_wire;

assign N_Selector_0_wire = {N_BITS{Selector[0]}};
assign N_Selector_1_wire = {N_BITS{Selector[1]}};

Mux_Two_To_One
#(
	.N_BITS(N_BITS)
)
Two_Mux_1
(
	// Input Ports
	.Selector(N_Selector_0_wire),
	.Data_0(Data_0),
	.Data_1(Data_1),
	
	// Output Ports
	.Mux_Output(Output_Two_Mux_1_wire)

);

Mux_Two_To_One
#(
	.N_BITS(N_BITS)
)
Two_Mux_2
(
	// Input Ports
	.Selector(N_Selector_0_wire),
	.Data_0(Data_2),
	.Data_1(Data_3),
	
	// Output Ports
	.Mux_Output(Output_Two_Mux_2_wire)

);

Mux_Two_To_One
#(
	.N_BITS(N_BITS)
)
Two_Mux_1_And_2
(
	// Input Ports
	.Selector(N_Selector_1_wire),
	.Data_0(Output_Two_Mux_1_wire),
	.Data_1(Output_Two_Mux_2_wire),
	
	// Output Ports
	.Mux_Output(Output_Two_Mux_1_And_2_wire)

);


assign Mux_Output = Output_Two_Mux_1_And_2_wire;


endmodule




