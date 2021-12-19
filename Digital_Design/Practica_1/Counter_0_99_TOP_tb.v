/**************************************************************************************
*	Description
*		This is the tb of a Counter_0_99_tb
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		08/07/20
***************************************************************************************/

/*`timescale <time_unit>/<time_precision>*/
`timescale 1ns/1ns //para una frecuencia de 50MHZ
//`timescale 1ns/1ns

module Counter_0_99_TOP_tb;

reg clk_FPGA_tb = 0;
reg reset_tb = 0;
reg enable_tb = 0;
reg A_D = 0;

//wire [6:0]num_O;
//wire [6:0]num_t;

wire a_O_tb;
wire b_O_tb;
wire c_O_tb;
wire d_O_tb;
wire e_O_tb;
wire f_O_tb;
wire g_O_tb;

wire a_t_tb;
wire b_t_tb;
wire c_t_tb;
wire d_t_tb;
wire e_t_tb;
wire f_t_tb;
wire g_t_tb;

Counter_0_99_TOP
DUV
(
	// Input Ports
	.clk(clk_FPGA_tb),
	.reset(reset_tb),
	.enable(enable_tb),
	.A_D(A_D),
	// Output Ports
	.a_O(a_O_tb),
	.b_O(b_O_tb),
	.c_O(c_O_tb),
	.d_O(d_O_tb),
	.e_O(e_O_tb),
	.f_O(f_O_tb),
	.g_O(g_O_tb),
	
	.a_t(a_t_tb),
	.b_t(b_t_tb),
	.c_t(c_t_tb),
	.d_t(d_t_tb),
	.e_t(e_t_tb),
	.f_t(f_t_tb),
	.g_t(g_t_tb)
	
);

/*********************************************************/
initial begin
	forever #10 clk_FPGA_tb = !clk_FPGA_tb;  //para una fecuencia de 50MHz
	//forever #500 clk_FPGA_tb = !clk_FPGA_tb;
	
end

initial begin
	#0 reset_tb = 1; 	
end

initial begin
	#0 enable_tb = 1; 	
end

initial begin
	#2500 A_D = 1; 	
end

/*********************************************************/

endmodule
