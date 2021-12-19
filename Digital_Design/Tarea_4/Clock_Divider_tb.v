/**************************************************************************************
*	Description
*		This is the tb of a clock divider
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		04/07/20
***************************************************************************************/

/*`timescale <time_unit>/<time_precision>*/
//`timescale 1ns/1ns //para una frecuencia de 50MHZ
`timescale 1ns/1ns

module Clock_Divider_tb;

reg clk_FPGA_tb = 0;
reg reset_tb = 0;

wire Clock_Signal_tb;


Clock_Divider
DUV
(
	// Input Ports
	.clk_FPGA(clk_FPGA_tb),
	.reset(reset_tb),
	// Output Ports
	.Clock_Signal(Clock_Signal_tb)
	
);

/*********************************************************/
initial begin
	//forever #10 clk_FPGA_tb = !clk_FPGA_tb;  //para una fecuencia de 50MHz
	forever #500 clk_FPGA_tb = !clk_FPGA_tb;
	
end

initial begin
	#0 reset_tb = 1; 
	

end
/*********************************************************/

endmodule
