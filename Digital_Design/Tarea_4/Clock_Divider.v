/**************************************************************************************
*	Description
*		This is a clock divider
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		04/07/20
***************************************************************************************/

module Clock_Divider
#(
	// Parameter Declarations
	parameter FRECUENCY = 1,
	parameter REFERENCE_CLOCK = 50000000
)
(
	// Input Ports
	input clk_FPGA,
	input reset,
	
	// Output Ports
	output Clock_Signal

);

localparam NBITS = CeilLog2_1(REFERENCE_CLOCK/FRECUENCY);

integer divisor = (REFERENCE_CLOCK/FRECUENCY);

reg Clock_Signal_Reg;

reg [NBITS-1 : 0] counter_reg;


/*********************************************************************************************/

	always@(posedge clk_FPGA or negedge reset) begin
		if (reset == 1'b0)
			counter_reg <= {NBITS{1'b0}};
		else begin
			if(counter_reg == divisor-1)
				counter_reg <= {NBITS{1'b0}};
			else
				counter_reg <= counter_reg + 1'b1;
		end
	end


always@(counter_reg, divisor) begin
	if(counter_reg >= divisor/2)
		Clock_Signal_Reg = 1;
	else
		Clock_Signal_Reg = 0;

end		
/*********************************************************************************************/
assign Clock_Signal = Clock_Signal_Reg;


/*********************************************************************************************/
/*********************************************************************************************/
   
 /*Log Function*/
     function integer CeilLog2_1;
       input integer data;
       integer i,result;
       begin
          for(i=0; 2**i < data; i=i+1)
             result = i + 1;
          CeilLog2_1 = result;
       end
    endfunction

endmodule


