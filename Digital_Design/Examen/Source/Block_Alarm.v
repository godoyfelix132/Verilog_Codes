module Block_Alarm
(
	input clk,
	input reset,
	input Set_Alarm,
	input MIN,
	input HR,
	 
	output [3:0]unit_min, 
	output [3:0]tens_min, 
	output [3:0]unit_hour, 
	output [3:0]tens_hour

);

wire carry_unit_min_wire;
wire carry_tens_min_wire;
wire carry_unit_hour_wire;

wire [3 : 0]out_count_min_unit_wire;
wire [3 : 0]out_count_min_tens_wire;
wire [3 : 0]out_count_hour_unit_wire;
wire [3 : 0]out_count_hour_tens_wire;

wire and_min_wire;
wire and_hour_wire;

wire mux_min_wire;



// MINUTES

And_Gate
#(
	.N_BITS(1)
)
And_min
(
	.A(Set_Alarm),
	.B(MIN),

	.C(and_min_wire)
);

Counter_With_Parameter
#(
	.MAXIMUM_VALUE(4'b1010),//9
	.INIT_VALUE(4'b0000)//0
)
Counter_Min_unit
(
	.clk(clk),
	.reset(reset),
	.enable(and_min_wire),
	
	.flag(carry_unit_min_wire),
	.counter(out_count_min_unit_wire)
);

Counter_With_Parameter
#(
	.MAXIMUM_VALUE(4'b1010),//9
	.INIT_VALUE(4'b0011)//3
)
Counter_Min_tens
(
	.clk(carry_unit_min_wire),
	.reset(reset),
	.enable(1'b1),
	
	.flag(carry_tens_min_wire),
	.counter(out_count_min_tens_wire)
);








// HOURS

And_Gate
#(
	.N_BITS(1)
)
And_hour
(
	.A(Set_Alarm),
	.B(HR),

	.C(and_hour_wire)
);

Multiplexer_Behavioral
#(
	.WORD_LENGTH(1)
)
Mux_hour
(
	.Selector(and_hour_wire),
	.Data_0(carry_tens_min_wire), 
	.Data_1(clk),
	
	.Mux_Output(mux_min_wire)
); 

Block_Format
#(
	.INIT(4'b0101)//5
)
Block_swith_units
(
	.clk(mux_min_wire),
	.reset(reset),
	.enable(1'b1),
	.switch_format(out_count_hour_tens_wire[1]),
	
	.flag(carry_unit_hour_wire),
	.counter(out_count_hour_unit_wire)
);



Counter_With_Parameter_Free
#(
	.NBITS(4),
	.MAXIMUM_VALUE(4'b0011),//3
	.INIT_VALUE(4'b0001)//1
)
Counter_Hour_tens
(
	.clk(carry_unit_hour_wire),
	.reset(reset),
	.enable(1'b1),
	
//	.flag(carry_tens_hour_wire),
	.counter(out_count_hour_tens_wire)
);

assign unit_min = out_count_min_unit_wire; 
assign tens_min = out_count_min_tens_wire; 
assign unit_hour = out_count_hour_unit_wire; 
assign tens_hour = out_count_hour_tens_wire;


endmodule
