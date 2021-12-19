/**************************************************************************************
*	Description
*		This is the tb for a sequential multiplier
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		14/07/20
***************************************************************************************/

/*`timescale <time_unit>/<time_precision>*/
`timescale 1ns/1ns 


module Sequential_Multiplier_tb;

parameter WORD_LENGTH = 5;

reg clk_tb = 0;
reg reset_tb = 0;
reg start_tb;
reg [WORD_LENGTH-1 : 0] Multiplicand_tb;
reg [WORD_LENGTH-1 : 0] Multiplier_tb;

wire ready_tb;
wire [2*WORD_LENGTH-1 : 0] Product_tb;

Structural_Sequential_Multiplier
DUV
(
	.clk(clk_tb),
	.reset(reset_tb),
	.start(start_tb),
	.Multiplicand(Multiplicand_tb),
	.Multiplier(Multiplier_tb),
	
	.ready(ready_tb),
	.Product(Product_tb)
);

initial begin
	forever #10 clk_tb = !clk_tb;
end

initial begin
	#40 reset_tb = 1;
end

initial begin
	#0 start_tb = 1;
	#20 start_tb = 0;
	#100 start_tb = 1;
	#800 start_tb = 0;
	#20 start_tb = 1;	
end 

initial begin
	#0 Multiplicand_tb = 10;
	#800 Multiplicand_tb = 15;
end 

initial begin
	#0 Multiplier_tb = -1;
	#800 Multiplier_tb = 15;
end 

endmodule
