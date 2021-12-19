module UART
(
	input RX_PORT,
	input [7:0]DATA_TX,
	input TX_SEND,
	input Clr_RX_Flag,
	input reset,
	input clk,
	
	output [7:0] Data_RX,
	output RX_Flag,
	output TX_Port,
	output Parity_Error
);

wire clk_wire_153600;
wire clk_wire_9600;


Clock_Divider
#(
	.FRECUENCY(153600),
	.REFERENCE_CLOCK(50000000)
)
clk_Divider_153600
(
	.clk_FPGA(clk),
	.reset(reset),
	
	.Clock_Signal(clk_wire_153600)
);

Clock_Divider
#(
	.FRECUENCY(9600),
	.REFERENCE_CLOCK(50000000)
)
clk_Divider_9600
(
	.clk_FPGA(clk),
	.reset(reset),
	
	.Clock_Signal(clk_wire_9600)
);


UART_sentData
UART_sentData0
(
	.clk(clk_wire_9600),  
   .dtr(TX_SEND),
	.mesage_tx(DATA_TX),
   .rstn(reset),
		
	.tx(TX_Port)
);



Block_RX
Block_RX0
(
	.RX_Port(RX_PORT),
	.clk(clk_wire_153600),
	.reset(reset),
	.Clr_RX_Flag(Clr_RX_Flag),
	
	.Data_RX(Data_RX),
	.Parity_Error(Parity_Error),
	.RX_Flag(RX_Flag)
);


endmodule
