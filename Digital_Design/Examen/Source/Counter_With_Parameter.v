

module Counter_With_Parameter
#(
	// Parameter Declarations
	parameter MAXIMUM_VALUE = 5'b11000,
	parameter NBITS = CeilLog2(MAXIMUM_VALUE),
	parameter INIT_VALUE = 5'b00001
)

(
	// Input Ports
	input clk,
	input reset,
	input enable,
	
	// Output Ports
	output flag,
	output[NBITS - 1:0] counter
);

reg MaxValue_Bit;

reg [NBITS-1 : 0] counter_reg;


//wire init_value_wire;
//
//assign init_value_wire = init_value;

/*********************************************************************************************/

	always@(posedge clk or negedge reset) begin
		if (reset == 1'b0)
			counter_reg <= INIT_VALUE;
		else begin
				if(enable == 1'b1) begin
					if(counter_reg == MAXIMUM_VALUE - 1)
						counter_reg <= 1'b0;
					else
						counter_reg <= counter_reg + 1'b1;
						
				end
		end
	end


always@(counter_reg)
	if(counter_reg == 0)
		MaxValue_Bit = 1;
	else
		MaxValue_Bit = 0;
		

		
/*********************************************************************************************/
assign flag = MaxValue_Bit;
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


