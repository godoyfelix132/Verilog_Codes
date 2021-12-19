/**************************************************************************************
*	Description
*		This is the tb for a Register file
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		24/07/20
***************************************************************************************/

/*`timescale <time_unit>/<time_precision>*/
`timescale 1ns/1ns 


module Register_File_tb;

parameter WORD_LENGTH = 8;

reg clk_tb = 0;
reg reset_tb = 0;
reg reg_Write_tb;
reg [2 : 0] Write_Register_tb;
reg [2 : 0] Read_Register_1_tb;
reg [2 : 0] Read_Register_2_tb;
reg [WORD_LENGTH-1 : 0] Write_Data_tb;

wire [WORD_LENGTH-1 : 0] Read_Data_1_tb;
wire [WORD_LENGTH-1 : 0] Read_Data_2_tb;

Register_File
DUV
(
	.clk(clk_tb),
	.reset(reset_tb),
	.reg_Write(reg_Write_tb),
	.Write_Register(Write_Register_tb),
	.Read_Register_1(Read_Register_1_tb),
	.Read_Register_2(Read_Register_2_tb),
	
	.Write_Data(Write_Data_tb),
	.Read_Data_1(Read_Data_1_tb),
	.Read_Data_2(Read_Data_2_tb)
);

initial begin
	forever #10 clk_tb = !clk_tb;
end

initial begin
	#0 reset_tb = 0;
	#20 reset_tb = 1;
end

initial begin
	#0 reg_Write_tb = 0;
	#25 reg_Write_tb = 1;
	#200 reg_Write_tb = 0;
end 

initial begin
	#0 Write_Data_tb = 3;
	#40 Write_Data_tb = 2;
	#40 Write_Data_tb = 20;
	#40 Write_Data_tb = 6;
	#40 Write_Data_tb= 78;
end 
initial begin
	#0 Write_Register_tb = 2;
	#40 Write_Register_tb = 4;
	#40 Write_Register_tb = 5;
	#40 Write_Register_tb = 6;
	#40 Write_Register_tb = 7;
end 
initial begin
	#0 Read_Register_1_tb = 0;
	#240 Read_Register_1_tb = 2;
	#40 Read_Register_1_tb = 4;
	#40 Read_Register_1_tb = 5;
	#40 Read_Register_1_tb = 6;
	#40 Read_Register_1_tb = 7;
end 

initial begin
	#0 Read_Register_2_tb = 0;
	#240 Read_Register_2_tb = 2;
	#40 Read_Register_2_tb = 4;
	#40 Read_Register_2_tb = 5;
	#40 Read_Register_2_tb = 6;
	#40 Read_Register_2_tb = 7;
end 


endmodule
