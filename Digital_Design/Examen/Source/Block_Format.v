module Block_Format
#(
	parameter INIT = 1'b1
)
(
	input clk,
	input enable,
	input switch_format,
	input reset,
	
	output flag,
	output [3:0]counter
);

wire not_switch_wire;

wire and_9_wire;
wire and_4_wire;

wire [3:0]count_9_wire;
wire [3:0]count_4_wire;

wire carry_9_wire;
wire carry_4_wire;

Not_Gate
#(
	.N_BITS(1)
)
Not_9format
(
	.A(switch_format),
	
	.B(not_switch_wire)
);

And_Gate
#(
	.N_BITS(1)
)
And_9formart
(
	.A(enable),
	.B(not_switch_wire),

	.C(and_9_wire)
);

And_Gate
#(
	.N_BITS(1)
)
And_4format
(
	.A(enable),
	.B(switch_format),

	.C(and_4_wire)
);

Counter_With_Parameter
#(
	.MAXIMUM_VALUE(4'b1010),//10
	.INIT_VALUE(INIT)
)
Counter_9format
(
	.clk(clk),
	.reset(reset),
	.enable(and_9_wire),
	
	.flag(carry_9_wire),
	.counter(count_9_wire)
);

Counter_With_Parameter
#(
	.MAXIMUM_VALUE(4'b0101),//5
	.NBITS(4),
	.INIT_VALUE(4'b0000)//0
)
Counter_4format
(
	.clk(clk),
	.reset(reset),
	.enable(and_4_wire),
	
	.flag(carry_4_wire),
	.counter(count_4_wire)
);

Multiplexer_Behavioral
#(
	.WORD_LENGTH(1)
)
Mux_carries
(
	.Selector(switch_format),
	.Data_0(carry_9_wire), 
	.Data_1(carry_4_wire),
	
	.Mux_Output(flag)
);

Multiplexer_Behavioral
#(
	.WORD_LENGTH(4)
)
Mux_counter
(
	.Selector(switch_format),
	.Data_0(count_9_wire), 
	.Data_1(count_4_wire),
	
	.Mux_Output(counter)
);  




endmodule
