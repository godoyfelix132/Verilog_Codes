module mips_8_bits
#(
	parameter DATA_INS_WIDTH=16, 
	parameter DATA_DAT_WIDTH=8, 
	parameter ADDR_WIDTH=6
)
( 
	input clk,
	input reset
	
);

wire [DATA_DAT_WIDTH-1 : 0] mux_1_wire;
MUX_4_To_1
#(
	.N_BITS(DATA_DAT_WIDTH)
)
MUX_1
(
	.Selector(1),
	.Data_0(0),//0
	.Data_1(mem_reg_wire[5:0]),
	.Data_2(pc_reg_wire),
	.Data_3(0),// not connection 
	

	.Mux_Output(mux_1_wire)

);

wire [DATA_DAT_WIDTH-1 : 0] pc_reg_wire;
Register_With_Enable
#(
	.WORD_LENGTH(DATA_DAT_WIDTH)
)
Program_counter
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.Data_Input(mux_1_wire),

	.Data_Output(pc_reg_wire)
);

wire [DATA_DAT_WIDTH-1 : 0] mux_2_wire;
MUX_4_To_1
#(
	.N_BITS(DATA_DAT_WIDTH)
)
MUX_2
(
	.Selector(1),
	.Data_0(1),
	.Data_1(pc_reg_wire),
	.Data_2(pc_reg_wire),
	.Data_3(0),//Not connection
	

	.Mux_Output(mux_2_wire)

);

wire [DATA_INS_WIDTH-1 : 0] mem_wire;
System_Memory
#(
	.DATA_INS_WIDTH(DATA_INS_WIDTH), 
	.DATA_DAT_WIDTH(DATA_DAT_WIDTH), 
	.ADDR_WIDTH(ADDR_WIDTH)
)
Memory
(
	.addr(mux_2_wire),
	.data(0),
	.q_selector(0),
	.we(0), 
	.clk(clk),
	
	.q(mem_wire)
	
);

wire [DATA_INS_WIDTH-1 : 0] mem_reg_wire;
Register_With_Enable
#(
	.WORD_LENGTH(DATA_DAT_WIDTH)
)
Memory_reg
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.Data_Input(mem_wire),

	.Data_Output(mem_reg_wire)
);

wire [DATA_DAT_WIDTH-1 : 0] a_wire;
wire [DATA_DAT_WIDTH-1 : 0] b_wire;
Register_File
(
    .clk(clk),
    .reset(reset),
    .reg_Write(0), //write
    .Write_Register(mem_reg_wire[11:9]), //address
    .Read_Register_1(mem_reg_wire[8:6]),
	 .Read_Register_2(mem_reg_wire[5:3]),
	 .Write_Data(a_reg_wire),//Data

    .Read_Data_1(a_wire),
    .Read_Data_2(b_wire)
);


wire [DATA_DAT_WIDTH-1 : 0] a_reg_wire;
Register_With_Enable
#(
	.WORD_LENGTH(DATA_DAT_WIDTH)
)
A_reg
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.Data_Input(a_wire),

	.Data_Output(a_reg_wire)
);

wire [DATA_DAT_WIDTH-1 : 0] b_reg_wire;
Register_With_Enable
#(
	.WORD_LENGTH(DATA_DAT_WIDTH)
)
B_reg
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.Data_Input(b_wire),

	.Data_Output(b_reg_wire)
);

wire [DATA_DAT_WIDTH-1 : 0] mux_3_wire;
MUX_4_To_1
#(
	.N_BITS(DATA_DAT_WIDTH)
)
MUX_3
(
	.Selector(1),
	.Data_0(mux_c_wire),
	.Data_1(pc_reg_wire),
	.Data_2(mem_wire[7:0]),
	.Data_3(a_reg_wire),
	

	.Mux_Output(mux_3_wire)

);

wire [DATA_DAT_WIDTH-1 : 0] mux_4_wire;
MUX_4_To_1
#(
	.N_BITS(DATA_DAT_WIDTH)
)
MUX_4
(
	.Selector(1),
	.Data_0(b_reg_wire),
	.Data_1(7'b00000001),
	.Data_2(mem_reg_wire[7:0]),
	.Data_3(mem_reg_wire[5:0]),
	

	.Mux_Output(mux_4_wire)

);

wire [DATA_DAT_WIDTH-1 : 0] alu_wire;
ALU
#(
    .WORD_LENGTH(DATA_DAT_WIDTH)
)
ALU_1
(
    .A(mux_3_wire),
    .B(mux_4_wire),
    .Control(0),

    .C(alu_wire)
);

wire [DATA_DAT_WIDTH-1 : 0] alu_reg_wire;
Register_With_Enable
#(
	.WORD_LENGTH(DATA_DAT_WIDTH)
)
ALU_reg
(
	.clk(clk),
	.reset(reset),
	.enable(1),
	.Data_Input(alu_wire),

	.Data_Output(alu_reg_wire)
);

wire [DATA_DAT_WIDTH-1 : 0] mux_c_wire;
Mux_Two_To_One
#(
	.N_BITS(DATA_DAT_WIDTH)
)
MUX_c
(
	.Selector(mem_reg_wire[8]),
	.Data_0(alu_reg_wire),
	.Data_1(7'b00000000),
	
	.Mux_Output(mux_c_wire)

);

endmodule
