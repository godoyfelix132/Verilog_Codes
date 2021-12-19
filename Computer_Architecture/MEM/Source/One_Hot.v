/**************************************************************************************
*	Description
*		This is a one hot
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		24/07/20
***************************************************************************************/

module One_Hot
(
	// Input Ports
	input [2 : 0] cod,
	input enable,
	
	// Output Ports
	output a, b, c, d, e, f, g, h
	
);

reg [7:0]cod_reg;

always@(*) begin
	if(enable == 0)
		cod_reg = 8'b00000000;
	else
		case(cod)		
			3'b000 : cod_reg = 8'b00000001;
			3'b001 : cod_reg = 8'b00000010;
			3'b010 : cod_reg = 8'b00000100;
			3'b011 : cod_reg = 8'b00001000;
			3'b100 : cod_reg = 8'b00010000;
			3'b101 : cod_reg = 8'b00100000;
			3'b110 : cod_reg = 8'b01000000;
			3'b111 : cod_reg = 8'b10000000;
			default: cod_reg = 8'b00000000;
		endcase
end

assign a = cod_reg[0];
assign b = cod_reg[1];
assign c = cod_reg[2];
assign d = cod_reg[3];
assign e = cod_reg[4];
assign f = cod_reg[5];
assign g = cod_reg[6];
assign h = cod_reg[7];

endmodule
