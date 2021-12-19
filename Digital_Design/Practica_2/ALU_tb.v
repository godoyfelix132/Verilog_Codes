/**************************************************************************************
*	Description
*		This is a tb to simulate an alu
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		10/07/20
***************************************************************************************/

/*`timescale <time_unit>/<time_precision>*/
`timescale 1ns/1ns 

module ALU_tb;

parameter WORD_LENGTH = 4;

reg [WORD_LENGTH-1:0]A_tb;
reg [WORD_LENGTH-1:0]B_tb;
reg [2:0]Control_tb;

wire Carry_tb;
wire [WORD_LENGTH-1:0] C_tb;

ALU
DUV
(
	.A(A_tb),
	.B(B_tb),
	.Control(Control_tb),
	
	.Carry(Carry_tb),
	.C(C_tb)
	
);

initial begin
	#0 A_tb[0] = 1; 
end
initial begin
	#0 A_tb[1] = 1; 
end
initial begin
	#0 A_tb[2] = 1; 
end
initial begin
	#0 A_tb[3] = 0; 
end



initial begin
	#0 B_tb[0] = 1; 
end
initial begin
	#0 B_tb[1] = 1;
end
initial begin
	#0 B_tb[2] = 0; 
end
initial begin
	#0 B_tb[3] = 0; 
end


initial begin
	#0  Control_tb[0] = 0;
	#10 Control_tb[0] = 1;
	#10 Control_tb[0] = 0;
	#10 Control_tb[0] = 1;
	#10 Control_tb[0] = 0;
	#10 Control_tb[0] = 1;
	#10 Control_tb[0] = 0;
	#10 Control_tb[0] = 1;
end
initial begin
	#0  Control_tb[1] = 0;
	#20 Control_tb[1] = 1;
	#20 Control_tb[1] = 0;
	#20 Control_tb[1] = 1;
end
initial begin
	#0  Control_tb[2] = 0;
	#40 Control_tb[2] = 1;
end

endmodule
