/**************************************************************************************
*	Description
*		This is a BCD to 7 segments in ecuations way 
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		03/07/20
***************************************************************************************/

module BCD_to_7seg_1
(
	// Input Ports
	input [3 : 0] bcd,
	
	// Output Ports
	output a, b, c, d, e, f, g
	
);

reg [6:0]bcd_reg;
wire x0 = (~bcd[3] & ~bcd[2] & ~bcd[1] & ~bcd[0]);//0000
wire x1 = (~bcd[3] & ~bcd[2] & ~bcd[1] & bcd[0]);//0001
wire x2 = (~bcd[3] & ~bcd[2] & bcd[1] & ~bcd[0]);//0010
wire x3 = (~bcd[3] & ~bcd[2] & bcd[1] & bcd[0]);//0011
wire x4 = (~bcd[3] & bcd[2] & ~bcd[1] & ~bcd[0]);//0100
wire x5 = (~bcd[3] & bcd[2] & ~bcd[1] & bcd[0]);//0101
wire x6 = (~bcd[3] & bcd[2] & bcd[1] & ~bcd[0]);//0110
wire x7 = (~bcd[3] & bcd[2] & bcd[1] & bcd[0]);//0111
wire x8 = (bcd[3] & ~bcd[2] & ~bcd[1] & ~bcd[0]);//1000
wire x9 = (bcd[3] & ~bcd[2] & ~bcd[1] & bcd[0]);//1001
wire x10a = (bcd[3] & ~bcd[2] & bcd[1] & ~bcd[0]);//1010
wire x11b = (bcd[3] & ~bcd[2] & bcd[1] & bcd[0]);//1011
wire x12c = (bcd[3] & bcd[2] & ~bcd[1] & ~bcd[0]);//1100
wire x13d = (bcd[3] & bcd[2] & ~bcd[1] & bcd[0]);//1101
wire x14e = (bcd[3] & bcd[2] & bcd[1] & ~bcd[0]);//1110
wire x15f = (bcd[3] & bcd[2] & bcd[1] & bcd[0]);//1111

always@(*) begin

	bcd_reg[0] = x1 || x4 || x11b || x13d;
	bcd_reg[1] = x5 || x6 || x11b || x12c || x14e || x15f;
	bcd_reg[2] = x2 || x12c || x14e || x15f;
	bcd_reg[3] = x1 || x4 || x7 || x9 || x10a || x15f;
	bcd_reg[4] = x1 || x3 || x4 || x5 || x7 || x9;
	bcd_reg[5] = x1 || x2 || x3 || x7 || x13d;
	bcd_reg[6] = x0 || x1 || x7 || x12c;
	
end

assign a = bcd_reg[0];
assign b = bcd_reg[1];
assign c = bcd_reg[2];
assign d = bcd_reg[3];
assign e = bcd_reg[4];
assign f = bcd_reg[5];
assign g = bcd_reg[6];

endmodule
