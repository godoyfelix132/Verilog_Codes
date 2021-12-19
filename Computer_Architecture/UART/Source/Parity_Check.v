module Parity_Check
(
	input [7:0]d,
	input parity,
	input enable,
	
	output result
);

reg result_reg;
reg xor_result_reg;

always@(*)begin
	if(enable)
	begin
		xor_result_reg = (((d[0])^(d[1]))^((d[2])^(d[3])))^(((d[4])^(d[5]))^((d[6])^(d[7])));
		if(parity == xor_result_reg)
			result_reg = 0;
		else
			result_reg = 1;
	end
	else
	begin
		result_reg = 0;
		xor_result_reg = 0;
	end
end 

assign result = result_reg;

endmodule
