/**************************************************************************************
*	Description
*		This is a clock divider
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		10/07/20
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

localparam NBITS = CeilLog2(REFERENCE_CLOCK/FRECUENCY);

localparam divisor = (REFERENCE_CLOCK/(2*FRECUENCY));

reg Clock_Signal_Reg = 0;

reg [NBITS-1 : 0] counter_reg;


/*********************************************************************************************/


always@(posedge clk_FPGA or negedge reset) begin
	
	if (reset == 1'b0)
	begin
		counter_reg <= {NBITS{1'b0}};
		Clock_Signal_Reg <= 0;
	end 
	
	else 
	begin
	
		if(counter_reg == divisor-1)
		begin
			Clock_Signal_Reg <= !Clock_Signal_Reg;
			counter_reg <= {NBITS{1'b0}};
		end 
		
		else
			counter_reg <= counter_reg + 1'b1;
	end
end

assign Clock_Signal = Clock_Signal_Reg;


/*********************************************************************************************/
/*********************************************************************************************/
   
 /*Log Function*/
     function integer CeilLog2;
       input integer data;
       integer i,result;
       begin
          for(i=0; 2**i < data; i=i+1)
             result = i + 1;
          CeilLog2 = result;
       end
    endfunction

endmodule


