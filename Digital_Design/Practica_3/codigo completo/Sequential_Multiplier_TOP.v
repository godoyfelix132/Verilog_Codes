module Sequential_Multiplier_TOP 
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

wire clk_inter/*synthesis keep*/;

Clock_Divider	Clock_Divider_inst 
(
	.inclk0 ( clk ),
	.c0 ( clk_inter )
);


Sequential_Multiplier
#(
	.WORD_LENGTH(WORD_LENGTH)
)
Control_1
(
	 .clk(clk_inter),
    .reset(reset),
    .start(start),
    .Multiplicand(Multiplicand),
    .Multiplier(Multiplier),

    .ready(ready),
    .Product(Product)
);

endmodule
