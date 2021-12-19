
module Multiplexer_Behavioral
#(
	parameter WORD_LENGTH = 5
)
(
	// Input Ports
	input Selector,
	input [WORD_LENGTH-1 : 0]Data_0,
	input [WORD_LENGTH-1 : 0]Data_1,
	
	// Output Ports
	output [WORD_LENGTH-1 : 0]Mux_Output

);

reg [WORD_LENGTH-1 : 0]Mux_Output_r;

always@(Selector, Data_1,Data_0) begin

	if (Selector == 1'b1)
		Mux_Output_r = Data_1;
	else 
		Mux_Output_r = Data_0;

end 

assign Mux_Output = Mux_Output_r;

endmodule




