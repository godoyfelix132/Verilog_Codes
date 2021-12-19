module Block_RX
(
	input RX_Port,
	input clk,
	input reset,
	input Clr_RX_Flag,
	
	output [7:0]Data_RX,
	output Parity_Error,
	output RX_Flag
);

wire [8:0]out_shift_wire;

wire shift_wire;
wire load_wire;
wire [8:0]value_wire;

wire done_wire;

Shift_Register
#(
	.WORD_LENGTH(9)
)
Shift_1
(
	.clk(clk),
	.reset(reset),
	.load(load_wire),
	.shift(shift_wire),
	.Parallel_Input(value_wire),
	
	.Parallel_Output(out_shift_wire)
	

);


Control_RX
Control_RX_1
(
	.in(RX_Port),
	.shift_out(out_shift_wire),
	.clk(clk),
	.reset(reset),
	.clear(~Clr_RX_Flag),
	
	.shift(shift_wire),
	.load(load_wire),
	.value(value_wire),
	.done(done_wire)
);

Parity_Check
Parity_Check_1
(
	.d(out_shift_wire[7:0]),
	.parity(out_shift_wire[8]),
	.enable(done_wire),
	
	.result(Parity_Error)
);

assign Data_RX = out_shift_wire[7:0];
assign RX_Flag = done_wire && Clr_RX_Flag;
//assign parity = out_shift_wire[0];

endmodule
