/**************************************************************************************
*	Description
*		This is a Shift Register
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		15/07/20
***************************************************************************************/

module Shift_Register
#(
	parameter WORD_LENGTH = 8
)
(
	input clk,
	input reset,
	input load,
	input shift,
	input [WORD_LENGTH - 1 : 0] Parallel_Input,
	
	output Serial_Output,
	output [WORD_LENGTH - 1 : 0] Parallel_Output
	

);

reg [WORD_LENGTH - 1 : 0]P_Out_reg;

always @(posedge clk or negedge reset) begin
	if(reset == 1'b0)
	begin
		P_Out_reg <= 0;
	end
	else
	begin
		if(load == 1'b1)
			P_Out_reg <= Parallel_Input;
		else
		begin
			if(shift == 1'b1)
				P_Out_reg <= P_Out_reg >> 1;
		end
	end
end

assign Serial_Output = Parallel_Output[WORD_LENGTH - 1];
assign Parallel_Output = P_Out_reg;

endmodule
