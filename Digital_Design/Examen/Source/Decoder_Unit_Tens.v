/**************************************************************************************
*	Description
*		This is a BCD to 7 segments in table way 
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		08/07/20
***************************************************************************************/

module Decoder_Unit_Tens
(
	// Input Ports
	input [4 : 0] cod,
	
	// Output Ports
	output units, tens
	
);

reg [3:0]cod_reg_1;
reg [3:0]cod_reg_2;

always@(cod) begin

	if(cod < 5'b00000)
		cod_reg_1 = cod[3:0];
	else
		cod_reg_1 = 0;
	
end

assign units = cod_reg_1;
assign tens = cod_reg_2;


endmodule
