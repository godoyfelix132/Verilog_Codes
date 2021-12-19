
module System_Memory
#(
	parameter DATA_INS_WIDTH=16, 
	parameter DATA_DAT_WIDTH=8, 
	parameter ADDR_WIDTH=6
)
(
	input [(ADDR_WIDTH-1):0] addr,
	input [(DATA_DAT_WIDTH-1):0] data,
	input q_selector,
	input we, 
	input clk,
	
	output [(DATA_INS_WIDTH-1):0] q
	
);

wire [(DATA_INS_WIDTH-1):0] q_instruction_wire;
wire [(DATA_DAT_WIDTH-1):0] q_data_wire;

single_port_rom
#(	
	.DATA_WIDTH(DATA_INS_WIDTH), 
	.ADDR_WIDTH(ADDR_WIDTH)
)
Intruction_memory
(
	.addr(addr),

	.q(q_instruction_wire)
);

single_port_ram 
#(
	.DATA_WIDTH(DATA_DAT_WIDTH), 
	.ADDR_WIDTH(ADDR_WIDTH)
)
Data_Memory
(
	.data(data),
	.addr(addr),
	.we(we), 
	.clk(clk),
	
	.q(q_data_wire)
);

Mux_Two_To_One
#(
	.N_BITS(DATA_INS_WIDTH)
)
Two_Mux_1
(
	.Selector(q_selector),
	.Data_0(q_instruction_wire),
	.Data_1({{8{1'b0}},q_data_wire}),
	
	.Mux_Output(q)
);



endmodule 