/**************************************************************************************
*	Description
*		This is a calculator with alu
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		10/07/20
***************************************************************************************/

module Calculator
#(
	parameter WORD_LENGTH = 4
)
(
	input clk,
	input reset,
	input [2:0] Control,
	input [WORD_LENGTH-1:0] A, B,
	
	output Carry,
	output [WORD_LENGTH-1:0] C

);

wire Output_clk_1Hz_wire;
wire [WORD_LENGTH-1:0] A_wire;
wire [WORD_LENGTH-1:0] B_wire;
wire [2:0] Control_wire;
wire Carry_wire;
wire [WORD_LENGTH-1:0] C_wire;

wire [2:0] Control_reg = {Control[2],~Control[1],~Control[0]};

Clock_Divider
Clk_1Hz
(
	// Input Ports
	.clk_FPGA(clk),
	.reset(reset),	
	// Output Ports
	.Clock_Signal(Output_clk_1Hz_wire)
);

Register
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Regiter_A
(
	.clk(Output_clk_1Hz_wire),
	.reset(reset),
	.Data_Input(A),

	.Data_Output(A_wire)
);

Register
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Regiter_B
(
	.clk(Output_clk_1Hz_wire),
	.reset(reset),
	.Data_Input(B),

	.Data_Output(B_wire)
);

Register
#(
	.WORD_LENGTH(3)
)
Regiter_Control
(
	.clk(Output_clk_1Hz_wire),
	.reset(reset),
	.Data_Input(Control_reg),

	.Data_Output(Control_wire)
);

ALU
#(
	.WORD_LENGTH(WORD_LENGTH)
)
ALU_1
(
	.A(A_wire),
	.B(B_wire),
	.Control(Control_wire),
	
	.Carry(Carry_wire),
	.C(C_wire)
	
);

Register
#(
	.WORD_LENGTH(1)
)
Regiter_Carry
(
	.clk(Output_clk_1Hz_wire),
	.reset(reset),
	.Data_Input(Carry_wire),

	.Data_Output(Carry)
);

Register
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Regiter_C
(
	.clk(Output_clk_1Hz_wire),
	.reset(reset),
	.Data_Input(C_wire),

	.Data_Output(C)
);

endmodule




