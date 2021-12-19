/**************************************************************************************
*	Description
*		This is a 0-9 counter
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		08/07/20
***************************************************************************************/

module Counter_Posedge
#(
	// Parameter Declarations
	parameter MAXIMUM_VALUE = 4'h9,
	parameter NBITS = CeilLog2(MAXIMUM_VALUE)
)

(
	// Input Ports
	input clk,
	input reset,
	input enable,
	input A_D,
	
	// Output Ports
	
	output carry,
	output[NBITS - 1:0] counter
	
);

reg MaxValue_Bit = 0;

reg [NBITS-1 : 0] counter_reg;

reg t_reg = 0;

/*********************************************************************************************/

always@(posedge clk or negedge reset) begin
	if (reset == 1'b0)
		counter_reg <= {NBITS{1'b0}};
	else begin
			if(enable == 1'b1) begin				
			
					if(A_D == 1'b1)begin
						if(counter_reg == MAXIMUM_VALUE)
							
							counter_reg <= 0;
						else
							counter_reg <= counter_reg + 1'b1;
					end
					
					else begin
							if (counter_reg == 0)
								counter_reg <= MAXIMUM_VALUE;
							else
								counter_reg <= counter_reg - 1'b1;
					end			
					
			end
	end
	
end

	

always@(counter_reg)begin
 
	if(A_D == 1'b1)begin
		if(counter_reg == MAXIMUM_VALUE)
			MaxValue_Bit = 1;
		else
			MaxValue_Bit = 0;
	end
	if(A_D == 1'b0)begin		
		if(counter_reg == 0)
			MaxValue_Bit = 1;
		else
			MaxValue_Bit = 0;
	end
	
end
		
/*********************************************************************************************/
assign carry = MaxValue_Bit;
assign counter = counter_reg;
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

/*********************************************************************************************/
endmodule


