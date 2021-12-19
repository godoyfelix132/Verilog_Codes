/**************************************************************************************
*	Description
*		This is a code to simulate MUX_8_to_1 and can be parameterized in it's bit-width.
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		26/06/20
***************************************************************************************/

/*`timescale <time_unit>/<time_precision>*/
`timescale 1ns/1ns

module Tarea_2_tb;

parameter Word_Length = 8;

reg [Word_Length- 1 :0] in1_tb = 0; 
reg [Word_Length- 1 :0 ] in2_tb = 0; 
reg [Word_Length- 1:0] in3_tb = 0; 
reg [Word_Length- 1 :0 ] in4_tb = 0; 
reg [Word_Length- 1 :0] in5_tb = 0; 
reg [Word_Length- 1 :0 ] in6_tb = 0; 
reg [Word_Length- 1:0] in7_tb = 0; 
reg [Word_Length- 1 :0 ] in8_tb = 0;

	
reg [2 : 0] sel_tb;

wire [Word_Length-1:0] out_tb;
	
	
MUX_8_to_1
#(
	.N_BITS(Word_Length)
)
DUV
(
	.Data_0(in1_tb), 
	.Data_1(in2_tb), 
	.Data_2(in3_tb), 
	.Data_3(in4_tb), 
	.Data_4(in5_tb), 
	.Data_5(in6_tb), 
	.Data_6(in7_tb), 
	.Data_7(in8_tb),
	.Selector(sel_tb), 
	.Mux_Output(out_tb)
	);

/*********************************************************/
initial begin // reset generator
	#0 in1_tb = 8'b11101011;

end
/*********************************************************/
initial begin // reset generator
	#0 in2_tb = 125;

end
/*********************************************************/
initial begin // reset generator
	#0 in3_tb = 8'hAA;

end
/*********************************************************/
initial begin // reset generator
	#0 in4_tb = 3;
end
/*********************************************************/
initial begin // reset generator
	#0 in5_tb = 8'b11111111;

end
/*********************************************************/
initial begin // reset generator
	#0 in6_tb = 12;

end
/*********************************************************/
initial begin // reset generator
	#0 in7_tb = 80;

end
/*********************************************************/
initial begin // reset generator
	#0 in8_tb = 30;
end
/*********************************************************/
initial begin // reset generator
	#0 sel_tb[0]  = 0;
	#10 sel_tb[0]  = 1;
	#10 sel_tb[0]  = 0;
	#10 sel_tb[0]  = 1;
	#10 sel_tb[0]  = 0;
	#10 sel_tb[0]  = 1;
	#10 sel_tb[0]  = 0;
	#10 sel_tb[0]  = 1;
end
/*********************************************************/
initial begin // reset generator
	#0 sel_tb[1]  = 0;
	#20 sel_tb[1]  = 1;
	#20 sel_tb[1]  = 0;
	#20 sel_tb[1]  = 1;
end
/*********************************************************/
initial begin // reset generator
	#0 sel_tb[2]  = 0;
	#40 sel_tb[2]  = 1;
end

endmodule
