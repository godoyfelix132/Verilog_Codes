/**************************************************************************************
*	Description
*		This is a Blinking Machine
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		10/07/20
***************************************************************************************/

module Blinking_Machine
(
	// Input Ports
	input clk,
	input reset,
	input start,
	
	// Output Ports
	output out,
	output Clk_1hz
//	output state

);

localparam INIT = 1;
localparam ON_1 = 2;
localparam OFF_1 = 3;
localparam ON_2 = 4;
localparam OFF_2 = 5;
localparam ON_3 = 6;
localparam OFF_3 = 7;

reg [2:0] state = 0;
reg [4:0] cicles = 0;
reg out_reg;
//wire start_wire;

wire clk_1hz_wire;


Clock_Divider
Clock
(
	.clk_FPGA(clk),
	.reset(reset),
	
	.Clock_Signal(clk_1hz_wire)

);

//Register
//#(
//	.WORD_LENGTH(1)
//)
//Register_start
//(
//	.clk(clk),
//	.reset(reset),
//	.Data_Input(start),
//
//	// Output Ports
//	.Data_Output(start_wire)
//);
//
//reg start_reg;

always@(posedge clk_1hz_wire or negedge reset) begin	
	if (reset == 1'b0)
	begin
		state <= INIT;
	end
	else
	begin
		cicles <= cicles + 4'b0001;
		case(state)
			INIT:
			if (start == 1'b0)
			begin
				state <= ON_1;
				cicles <= 4'b0000;
			end
			else
				state <= INIT;
			ON_1:
			if (cicles == 5'b00110)
				state <= OFF_1;
			else
				state <= ON_1;
			OFF_1:
			if (cicles == 5'b01010)
				state <= ON_2;
			else
				state <= OFF_1;
			ON_2:
			if (cicles == 5'b10000)
				state <= OFF_2;
			else
				state <= ON_2;
			OFF_2:
			if (cicles == 5'b10100)
				state <= ON_3;
			else
				state <= OFF_2;
			ON_3:
			if (cicles == 5'b11010)
				state <= OFF_3;
			else
				state <= ON_3;
			OFF_3:
			if (cicles == 5'b11110)
				state <= INIT;
			else
				state <= OFF_3;
			default: 
				state <= INIT;
		endcase
	end
end

always @(*) begin
	case (state)
		INIT:
		begin
			out_reg = 0;
		end 
		ON_1:
		begin
			out_reg = 1;
		end
		OFF_1:
		begin
			out_reg = 0;
		end
		ON_2:
		begin
			out_reg = 1;
		end
		OFF_2:
		begin
			out_reg = 0;
		end
		ON_3:
		begin
			out_reg = 1;
		end
		OFF_3:
		begin
			out_reg = 0;
		end
		default: 
			out_reg = 0;
	endcase	
end

assign out = out_reg;
assign Clk_1hz = clk_1hz_wire;

endmodule


