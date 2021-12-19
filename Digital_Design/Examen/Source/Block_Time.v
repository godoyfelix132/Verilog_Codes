module Block_Time
(
	input clk,
	input reset,
	input enable,
	input Set_clock,
	input MIN,
	input HR,
	
	output [3:0]unit_seg, 
	output [3:0]tens_seg, 
	output [3:0]unit_min, 
	output [3:0]tens_min, 
	output [3:0]unit_hour, 
	output [3:0]tens_hour,
	output flag
);


wire carry_unit_seg_wire;
wire carry_tens_seg_wire;
wire carry_unit_min_wire;
wire carry_tens_min_wire;
wire carry_unit_hour_wire;
wire carry_tens_hour_wire;

wire [3 : 0]out_count_seg_unit_wire;
wire [3 : 0]out_count_seg_tens_wire;
wire [3 : 0]out_count_min_unit_wire;
wire [3 : 0]out_count_min_tens_wire;
wire [3 : 0]out_count_hour_unit_wire;
wire [1 : 0]out_count_hour_tens_wire;

wire and_min_wire;
wire and_hour_wire;

wire and_format_wire;

wire mux_seg_wire;
wire mux_min_wire;

// SECONDS

Counter_With_Parameter
#(
	.MAXIMUM_VALUE(4'b1010),//10
	.INIT_VALUE(4'b0101)//5
)
Counter_Seg_unit
(
	.clk(clk),
	.reset(reset),
	.enable(enable),
	
	.flag(carry_unit_seg_wire),
	.counter(out_count_seg_unit_wire)
);

//One_Shot
//One_Shot_seg_Unit
//(
//	.clk(clk),
//	.reset(reset),
//	.Start(carry_unit_seg_wire),
//
//	.Shot(shot_seg_unit)
//);

Counter_With_Parameter
#(
	.MAXIMUM_VALUE(4'b1010),//10
	.INIT_VALUE(4'b0010)//2
)
Counter_Seg_tens
(
	.clk(carry_unit_seg_wire),
	.reset(reset),
	.enable(enable),
	
	.flag(carry_tens_seg_wire),
	.counter(out_count_seg_tens_wire)
);


And_Gate
#(
	.N_BITS(1)
)
And_min
(
	.A(Set_clock),
	.B(MIN),

	.C(and_min_wire)
);

//Or_Gate
//#(
//	.N_BITS(1)
//)
//Or_Seg
//(
//	.A(carry_tens_seg_wire),
//	.B(and_min_wire),
//	
//	.C(or_min_wire)
//);

Multiplexer_Behavioral
#(
	.WORD_LENGTH(1)
)
Mux_seg
(
	.Selector(and_min_wire),
	.Data_0(carry_tens_seg_wire), 
	.Data_1(clk),
	
	.Mux_Output(mux_seg_wire)
);  

//One_Shot
//One_Shot_seg_tens
//(
//	.clk(clk),
//	.reset(reset),
//	.Start(or_min_wire),
//
//	.Shot(shot_seg_tens)
//);

// MINUTES

Counter_With_Parameter
#(
	.MAXIMUM_VALUE(4'b1010),//10
	.INIT_VALUE(4'b0101)//5
)
Counter_Min_unit
(
	.clk(mux_seg_wire),
	.reset(reset),
	.enable(enable),
	
	.flag(carry_unit_min_wire),
	.counter(out_count_min_unit_wire)
);
//
//One_Shot
//One_Shot_min_Unit
//(
//	.clk(clk),
//	.reset(reset),
//	.Start(carry_unit_min_wire),
//
//	.Shot(shot_min_unit)
//);

Counter_With_Parameter
#(
	.MAXIMUM_VALUE(4'b1010),//10
	.INIT_VALUE(4'b0011)//3
)
Counter_Min_tens
(
	.clk(carry_unit_min_wire),
	.reset(reset),
	.enable(enable),
	
	.flag(carry_tens_min_wire),
	.counter(out_count_min_tens_wire)
);

//One_Shot
//One_Shot_min_tens
//(
//	.clk(clk),
//	.reset(reset),
//	.Start(carry_tens_min_wire),
//
//	.Shot(shot_min_tens)
//);

// HOUR


And_Gate
#(
	.N_BITS(1)
)
And_hour
(
	.A(Set_clock),
	.B(HR),

	.C(and_hour_wire)
);

//Or_Gate
//#(
//	.N_BITS(1)
//)
//Or_hour
//(
//	.A(carry_tens_min_wire),
//	.B(and_hour_wire),
//	
//	.C(or_hour_wire)
//);


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


//One_Shot
//One_Shot_hour_unit
//(
//	.clk(clk),
//	.reset(reset),
//	.Start(or_hour_wire),
//
//	.Shot(shot_hour_unit)
//);


Block_Format
#(
	.INIT(4'b0101)//5
)
Block_swith_units
(
	.clk(mux_min_wire),
	.reset(reset),
	.enable(enable),
	.switch_format(out_count_hour_tens_wire[1]),
	
	.flag(carry_unit_hour_wire),
	.counter(out_count_hour_unit_wire)
);

//One_Shot
//One_Shot_hour_tens
//(
//	.clk(clk),
//	.reset(reset),
//	.Start(carry_unit_hour_wire),
//
//	.Shot(shot_hour_tens)
//);

Counter_With_Parameter
#(
	.MAXIMUM_VALUE(2'b11),//3
	.INIT_VALUE(2'b01)//1
)
Counter_Hour_tens
(
	.clk(carry_unit_hour_wire),
	.reset(reset),
	.enable(enable),
	
	.flag(carry_tens_hour_wire),
	.counter(out_count_hour_tens_wire)
);


assign unit_seg = out_count_seg_unit_wire;
assign tens_seg = out_count_seg_tens_wire;
assign unit_min = out_count_min_unit_wire;
assign tens_min = out_count_min_tens_wire;
assign unit_hour = out_count_hour_unit_wire;
assign tens_hour = out_count_hour_tens_wire;
assign flag = carry_tens_hour_wire;

endmodule
