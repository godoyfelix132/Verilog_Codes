/**************************************************************************************
*	Description
*		This is a register file
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		24/07/20
***************************************************************************************/

module Register_File
(
    input clk,
    input reset,
    input reg_Write,
    input [2 : 0] Write_Register,
    input [2 : 0] Read_Register_1,
	 input [2 : 0] Read_Register_2,
	 input [7 : 0] Write_Data,

    output [7 : 0]Read_Data_1,
    output [7 : 0]Read_Data_2
);

localparam WORD_LENGTH = 8;

wire [WORD_LENGTH - 1 : 0]out_reg_0;
wire [WORD_LENGTH - 1 : 0]out_reg_1;
wire [WORD_LENGTH - 1 : 0]out_reg_2;
wire [WORD_LENGTH - 1 : 0]out_reg_3;
wire [WORD_LENGTH - 1 : 0]out_reg_4;
wire [WORD_LENGTH - 1 : 0]out_reg_5;
wire [WORD_LENGTH - 1 : 0]out_reg_6;
wire [WORD_LENGTH - 1 : 0]out_reg_7;


wire out_and_0;
wire out_and_1;
wire out_and_2;
wire out_and_3;
wire out_and_4;
wire out_and_5;
wire out_and_6;
wire out_and_7;

wire out_dec_0;
wire out_dec_1;
wire out_dec_2;
wire out_dec_3;
wire out_dec_4;
wire out_dec_5;
wire out_dec_6;
wire out_dec_7;

wire out_one_shot;


//ONE HOT
One_Hot
One_Hot_0
(
	.cod(Write_Register),
	.enable(reg_Write),
	
	.a(out_dec_0), 
	.b(out_dec_1), 
	.c(out_dec_2), 
	.d(out_dec_3), 
	.e(out_dec_4), 
	.f(out_dec_5), 
	.g(out_dec_6), 
	.h(out_dec_7)
);



//REGISTERS
Register_With_Enable
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Register_0
(
	.clk(clk),
	.reset(reset),
	.enable(out_dec_0),
	.Data_Input(Write_Data),

	.Data_Output(out_reg_0)
);

Register_With_Enable
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Register_1
(
	.clk(clk),
	.reset(reset),
	.enable(out_dec_1),
	.Data_Input(Write_Data),

	.Data_Output(out_reg_1)
);
Register_With_Enable
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Register_2
(
	.clk(clk),
	.reset(reset),
	.enable(out_dec_2),
	.Data_Input(Write_Data),

	.Data_Output(out_reg_2)
);

Register_With_Enable
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Register_3
(
	.clk(clk),
	.reset(reset),
	.enable(out_dec_3),
	.Data_Input(Write_Data),

	.Data_Output(out_reg_3)
);

Register_With_Enable
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Register_4
(
	.clk(clk),
	.reset(reset),
	.enable(out_dec_4),
	.Data_Input(Write_Data),

	.Data_Output(out_reg_4)
);

Register_With_Enable
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Register_5
(
	.clk(clk),
	.reset(reset),
	.enable(out_dec_5),
	.Data_Input(Write_Data),

	.Data_Output(out_reg_5)
);

Register_With_Enable
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Register_6
(
	.clk(clk),
	.reset(reset),
	.enable(out_dec_6),
	.Data_Input(Write_Data),

	.Data_Output(out_reg_6)
);

Register_With_Enable
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Register_7
(
	.clk(clk),
	.reset(reset),
	.enable(out_dec_7),
	.Data_Input(Write_Data),

	.Data_Output(out_reg_7)
);


//MUX 8 TO 1
MUX_8_to_1
#(
	.N_BITS(WORD_LENGTH)
)
Mux_1
(
	.Selector(Read_Register_1),
	.Data_0(out_reg_0),
	.Data_1(out_reg_1),
	.Data_2(out_reg_2),
	.Data_3(out_reg_3),
	.Data_4(out_reg_4),
	.Data_5(out_reg_5),
	.Data_6(out_reg_6),
	.Data_7(out_reg_7),
	
	.Mux_Output(Read_Data_1)
);

MUX_8_to_1
#(
	.N_BITS(WORD_LENGTH)
)
Mux_2
(
	.Selector(Read_Register_2),
	.Data_0(out_reg_0),
	.Data_1(out_reg_1),
	.Data_2(out_reg_2),
	.Data_3(out_reg_3),
	.Data_4(out_reg_4),
	.Data_5(out_reg_5),
	.Data_6(out_reg_6),
	.Data_7(out_reg_7),
	
	.Mux_Output(Read_Data_2)
);


endmodule
