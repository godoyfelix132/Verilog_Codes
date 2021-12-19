/**************************************************************************************
*	Description
*		This is the tb for a Blinking machine
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		10/07/20
***************************************************************************************/

/*`timescale <time_unit>/<time_precision>*/
`timescale 1ns/1ns //para una frecuencia de 50MHZ
//`timescale 1ns/1ns

module Blinking_Machine_tb;

reg clk_tb = 0;
reg reset_tb = 0;
reg start_tb = 0;

wire out_tb;
wire Clk_1hz_tb;

Blinking_Machine
DUV
(
	.clk(clk_tb),
	.reset(reset_tb),
	.start(start_tb),

	.out(out_tb),
	.Clk_1hz(Clk_1hz_tb)
	
);

initial begin
	forever #10 clk_tb = !clk_tb;
	
end

initial begin
	#0 reset_tb = 1;
end

initial begin
	#0 start_tb = 1;
	#100 start_tb = 0;
	#500 start_tb = 1;
end 

endmodule
