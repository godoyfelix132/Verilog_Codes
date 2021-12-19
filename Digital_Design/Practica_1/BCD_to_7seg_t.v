/**************************************************************************************
*	Description
*		This is a BCD to 7 segments in table way 
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		08/07/20
***************************************************************************************/

module BCD_to_7seg
(
	// Input Ports
	input [3 : 0] bcd,
	
	// Output Ports
	output a, b, c, d, e, f, g
	
);

reg [6:0]bcd_reg;

always@(bcd) begin

	case(bcd)
		//                     g_fed_cba	
		4'b0000 : bcd_reg = 7'b1_000_000;//0
		4'b0001 : bcd_reg = 7'b1_111_001;//1
		4'b0010 : bcd_reg = 7'b0_100_100;//2
		4'b0011 : bcd_reg = 7'b0_110_000;//3
		4'b0100 : bcd_reg = 7'b0_011_001;//4
		4'b0101 : bcd_reg = 7'b0_010_010;//5
		4'b0110 : bcd_reg = 7'b0_000_010;//6
		4'b0111 : bcd_reg = 7'b1_111_000;//7
		4'b1000 : bcd_reg = 7'b0_000_000;//8
		4'b1001 : bcd_reg = 7'b0_011_000;//9
		
		default: bcd_reg = 7'b1_111_111;
	endcase
	
end

assign a = bcd_reg[0];
assign b = bcd_reg[1];
assign c = bcd_reg[2];
assign d = bcd_reg[3];
assign e = bcd_reg[4];
assign f = bcd_reg[5];
assign g = bcd_reg[6];

endmodule
