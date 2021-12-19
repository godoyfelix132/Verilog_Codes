module Adder
#(
    parameter WORD_LENGTH = 8
) 
(
	 input clk,
	 input reset,
    input [WORD_LENGTH - 1 : 0]a,
    input [WORD_LENGTH - 1 : 0]b,
	 
    output [WORD_LENGTH - 1 : 0]sum    
);

reg [WORD_LENGTH-1 : 0]sum_reg = 0;

always @(negedge clk or negedge reset) begin
    sum_reg = a + b;
end

assign sum = sum_reg;

endmodule
