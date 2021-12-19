/**************************************************************************************
*	Description
*		This is an alu
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		10/07/20
***************************************************************************************/

module ALU
#(
    parameter WORD_LENGTH = 4
)
(
    input [WORD_LENGTH-1:0]A,
    input [WORD_LENGTH-1:0]B,
    input [2:0]Control,

    output Carry,
    output [WORD_LENGTH-1:0] C
);

reg [WORD_LENGTH-1:0]mask = {WORD_LENGTH{1'b1}};
reg [WORD_LENGTH-1:0]c_reg;
reg carry_reg;
reg [(2*WORD_LENGTH)-1:0]c_temp_reg;

always @(*) begin

	case (Control)
	3'b000: c_temp_reg = A + B;
	3'b001: c_temp_reg = A - B;
	3'b010: c_temp_reg = A * B;
	3'b011: c_temp_reg = ~A;
	3'b100: c_temp_reg = ~A + 1'b1;
	3'b101: c_temp_reg = A & B;
	3'b110: c_temp_reg = A | B;
	3'b111: c_temp_reg = A ^ B; 
	default: c_temp_reg = 0; 
	endcase

	if (c_temp_reg > mask && Control != 3'b011 && Control != 3'b100) begin
		carry_reg = 1'b1;
	end
	else begin
		carry_reg = 1'b0;
	end
	
   c_reg = c_temp_reg[WORD_LENGTH-1:0];

end

assign C = c_reg;
assign Carry = carry_reg;    
	 
endmodule
