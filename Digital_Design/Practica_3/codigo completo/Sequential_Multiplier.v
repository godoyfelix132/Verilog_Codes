module Sequential_Multiplier 
#(
    parameter WORD_LENGTH = 5
) 
(
    input clk,
    input reset,
    input start,
    input [WORD_LENGTH-1 : 0] Multiplicand,
    input [WORD_LENGTH-1 : 0] Multiplier,

    output ready,
    output [2*WORD_LENGTH-1 : 0] Product
);

wire [2*WORD_LENGTH-1 : 0]Reg_Multiplicand_wire;
wire [2*WORD_LENGTH-1 : 0]Reg_Multiplier_wire;
wire [2*WORD_LENGTH-1 : 0]Shift_Multiplicand_wire;
wire [2*WORD_LENGTH-1 : 0]Shift_Multiplier_wire;
wire [2*WORD_LENGTH-1 : 0]Mux_Value_To_Add_wire;
wire [2*WORD_LENGTH-1 : 0]Add_Adder_wire;
wire [2*WORD_LENGTH-1 : 0]Mux_Clean_wire;
wire [2*WORD_LENGTH-1 : 0]Reg_Product_wire;
wire [2*WORD_LENGTH-1 : 0]Mux_Show_wire;

wire load_wire;
wire value_to_add_wire;
wire clear_product_wire;
wire show_product_wire;
wire ready_wire;
wire and_multiplicand_wire;
wire shift_wire;
reg product_reg;
reg ready_reg;



wire [2*WORD_LENGTH-1 : 0] full_multiplicand = {2*WORD_LENGTH{Multiplicand[WORD_LENGTH-1]}} - {WORD_LENGTH{Multiplicand[WORD_LENGTH-1]}} + Multiplicand;
wire [2*WORD_LENGTH-1 : 0] full_Multiplier = {2*WORD_LENGTH{Multiplier[WORD_LENGTH-1]}} - {WORD_LENGTH{Multiplier[WORD_LENGTH-1]}} + Multiplier;

Control
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Control_1
(
	 .clk(clk),
    .start(start),
    .reset(reset),
    .Multiplier(Shift_Multiplier_wire),

    .load(load_wire),
    .shift(shift_wire),
    .value_to_add(value_to_add_wire),
    .clear_product(clear_product_wire),
    .show_product(show_product_wire),
	 .ready(ready_wire)
);

Register_With_Enable
#(
	.WORD_LENGTH(2*WORD_LENGTH)
)
Register_Multiplicand
(
	.clk(clk),
	.reset(reset),
	.enable(1),//control
	.Data_Input(full_multiplicand),


	.Data_Output(Reg_Multiplicand_wire)
);



Multiplexer_Behavioral
#(
	.WORD_LENGTH(2*WORD_LENGTH)
)
Multiplexer_Value_To_Add
(
	.Selector(value_to_add_wire),//control
	.Data_0(0),
	.Data_1(Shift_Multiplicand_wire),
	
	.Mux_Output(Mux_Value_To_Add_wire)
);

Adder
#(
	.WORD_LENGTH(2*WORD_LENGTH)
)
Adder_1
(
	.clk(clk),
	.reset(reset),
	.a(Mux_Value_To_Add_wire),
   .b(Reg_Product_wire),
	 
   .sum(Add_Adder_wire) 
); 


Multiplexer_Behavioral
#(
	.WORD_LENGTH(2*WORD_LENGTH)
)
Multiplexer_Clean
(
	.Selector(clear_product_wire),//control
	.Data_0(Add_Adder_wire),
	.Data_1(0),
	
	.Mux_Output(Mux_Clean_wire)
);


Register_With_Enable
#(
	.WORD_LENGTH(2*WORD_LENGTH)
)
Register_Product
(
	.clk(clk),
	.reset(reset),
	.enable(~ready_wire),//control
	.Data_Input(Mux_Clean_wire),


	.Data_Output(Reg_Product_wire)
);

Multiplexer_Behavioral
#(
	.WORD_LENGTH(2*WORD_LENGTH)
)
Multiplexer_Show
(
	.Selector(show_product_wire),//control
	.Data_0(0),
	.Data_1(Reg_Product_wire),
	
	.Mux_Output(Product)
);


Register_With_Enable
#(
	.WORD_LENGTH(2*WORD_LENGTH)
)
Register_Multiplier
(
	.clk(clk),
	.reset(reset),
	.enable(1),//control
	.Data_Input(full_Multiplier),


	.Data_Output(Reg_Multiplier_wire)
);

Shift_Register_rigth
#(
	.WORD_LENGTH(2*WORD_LENGTH)
)
Shift_Multiplier_r
(
	.clk(clk),
	.reset(reset),
	.load(load_wire),//control
	.shift(shift_wire),//control
	.Parallel_Input(Reg_Multiplier_wire),
	
	.Parallel_Output(Shift_Multiplier_wire)

);

Shift_Register_left
#(
	.WORD_LENGTH(2*WORD_LENGTH)
)
Shift_Multiplicand_l
(
	.clk(clk),
	.reset(reset),
	.load(load_wire),//control
	.shift(shift_wire),//control
	.Parallel_Input(Reg_Multiplicand_wire),
	
	.Parallel_Output(Shift_Multiplicand_wire)

);


assign ready = ready_wire;
  
endmodule
