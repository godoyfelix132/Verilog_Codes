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

module UART_tb;

reg RX_Port_tb = 0;
reg clk_tb = 0;
reg reset_tb = 0;
reg Clr_RX_Flag_tb = 1;

wire [7:0]Data_RX_tb;
wire Parity_Error_tb;
wire RX_Flag_tb;


Block_RX
DUV
(
	.RX_Port(RX_Port_tb),
	.clk(clk_tb),
	.reset(reset_tb),
	.Clr_RX_Flag(Clr_RX_Flag_tb),
	
	.Data_RX(Data_RX_tb),
	.Parity_Error(Parity_Error_tb),
	.RX_Flag(RX_Flag_tb)
);

/*********************************************************/
initial begin
	forever #10 clk_tb = !clk_tb;  //para una fecuencia de 50MHz
	//forever #500 clk_FPGA_tb = !clk_FPGA_tb;
	
end

initial begin
	#0 reset_tb = 0;
	#20 reset_tb = 1;
end

initial begin
	#0 RX_Port_tb = 1; 	
	//START
	#104166 RX_Port_tb = 0; 	
	//DATA I 
	#104166 RX_Port_tb = 1;
	#104166 RX_Port_tb = 0;
	#104166 RX_Port_tb = 0;
	#104166 RX_Port_tb = 1;
	#104166 RX_Port_tb = 0;
	#104166 RX_Port_tb = 0;
	#104166 RX_Port_tb = 1;
	#104166 RX_Port_tb = 0;
	//PARITY
	#104166 RX_Port_tb = 1;
	//STOP
	#104166 RX_Port_tb = 1;
	
	//START
	#104166 RX_Port_tb = 0; 	
	//DATA N
	#104166 RX_Port_tb = 0;
	#104166 RX_Port_tb = 1;
	#104166 RX_Port_tb = 1;
	#104166 RX_Port_tb = 1;
	#104166 RX_Port_tb = 0;
	#104166 RX_Port_tb = 0;
	#104166 RX_Port_tb = 1;
	#104166 RX_Port_tb = 0;
	//PARITY
	#104166 RX_Port_tb = 1;
	//STOP
	#104166 RX_Port_tb = 1;
	
	//CLEAR
	#204166 Clr_RX_Flag_tb = 0;
	#104166 Clr_RX_Flag_tb = 1;
	
	//START
	#104166 RX_Port_tb = 0; 	
	//DATA T
	#104166 RX_Port_tb = 0;
	#104166 RX_Port_tb = 0;
	#104166 RX_Port_tb = 1;
	#104166 RX_Port_tb = 0;
	#104166 RX_Port_tb = 1;
	#104166 RX_Port_tb = 0;
	#104166 RX_Port_tb = 1;
	#104166 RX_Port_tb = 0;
	//PARITY
	#104166 RX_Port_tb = 1;
	//STOP
	#104166 RX_Port_tb = 1;
	
end


/*********************************************************/

endmodule
