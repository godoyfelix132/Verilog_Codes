/**************************************************************************************
*	Description
*		This is a 8 to 1 multiplexer that can be parameterized in it's bit-width.
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		26/06/20
***************************************************************************************/

module Counter_0_99_TOP

(
	input clk,
	input reset,
	input enable,
	input A_D,
	
	output a_O, b_O, c_O, d_O, e_O, f_O, g_O,
	output a_t, b_t, c_t, d_t, e_t, f_t, g_t

);

wire Output_clk_1Hz_wire;
wire Output_carry_wire;
wire [3 : 0]Output_bcd_units_wire;
wire [3 : 0]Output_bcd_tens_wire;
wire [6 : 0]Output_7seg_units_wire;
wire [6 : 0]Output_7seg_tens_wire;




Clock_Divider
Clk_1Hz
(
	// Input Ports
	.clk_FPGA(clk),
	.reset(reset),
	
	// Output Ports
	.Clock_Signal(Output_clk_1Hz_wire)
);
/**************************************************************************************
*	Description
*		This is a 0-99 counter
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		08/07/20
***************************************************************************************/

Counter_Posedge
Counter_Units
(
	// Input Ports
	.clk(Output_clk_1Hz_wire),
	.reset(reset),
	.enable(enable),
	.A_D(A_D),
	
	// Output Ports
	.carry(Output_carry_wire),
	.counter(Output_bcd_units_wire)

);


Counter_Posedge
Counter_Tens
(
	// Input Ports
	.clk(Output_clk_1Hz_wire),
	.reset(reset),
	.enable(Output_carry_wire),
	.A_D(A_D),
	
	// Output Ports
	.counter(Output_bcd_tens_wire)

);

BCD_to_7seg
BCD_Units
(
	// Input Ports
	.bcd(Output_bcd_units_wire),
	
	// Output Ports
	.a(a_O), 
	.b(b_O), 
	.c(c_O), 
	.d(d_O), 
	.e(e_O), 
	.f(f_O), 
	.g(g_O)
);


BCD_to_7seg
BCD_Tens
(
	// Input Ports
	.bcd(Output_bcd_tens_wire),
	
	// Output Ports
	.a(a_t), 
	.b(b_t), 
	.c(c_t), 
	.d(d_t), 
	.e(e_t), 
	.f(f_t), 
	.g(g_t)
);

endmodule




