module Control_RX
(
	input in,
	input [8:0]shift_out,
	input clk,
	input reset,
	input clear,
	
	output shift,
	output load,
	output [8:0]value,
	output done

	
);

localparam INIT = 11;
localparam START = 12;
localparam READ_0 = 0;
localparam READ_1 = 1;
localparam READ_2 = 2;
localparam READ_3 = 3;
localparam READ_4 = 4;
localparam READ_5 = 5;
localparam READ_6 = 6;
localparam READ_7 = 7;
localparam READ_PARITY = 8;
localparam FINISH = 9;
localparam CLEAR = 10;

reg shift_reg;
reg load_reg;
reg [8:0]value_reg;
reg done_reg;

reg [3:0]cicles;
reg [3:0] state = 9;

always@(posedge clk or negedge reset) begin
	if(reset == 1'b0)
	begin
		state <= INIT;
		cicles <= 4'b0000;
	end
	else
	begin
		case(state)
			INIT:
			begin
				cicles <= 4'b0000;
				if(in == 0)
					state <= START;
				else
					state <= INIT;
			end			
			START:
			begin
				cicles <= cicles + 4'b0001;
				if(cicles == 4'b1111)
				begin
					cicles <= 4'b0000;
					state <= READ_0;
				end
				else
					state <= START;	
			end
			
			READ_0:
			begin
				cicles <= cicles + 4'b0001;
				if(cicles == 4'b1111)
				begin
					cicles <= 4'b0000;
					state <= READ_1;
				end
				else
					state <= READ_0;	
			end
			
			READ_1:
			begin
				cicles <= cicles + 4'b0001;
				if(cicles == 4'b1111)
				begin
					cicles <= 4'b0000;
					state <= READ_2;
				end
				else
					state <= READ_1;	
			end
			
			READ_2:
			begin
				cicles <= cicles + 4'b0001;
				if(cicles == 4'b1111)
				begin
					cicles <= 4'b0000;
					state <= READ_3;
				end
				else
					state <= READ_2;	
			end
			
			READ_3:
			begin
				cicles <= cicles + 4'b0001;
				if(cicles == 4'b1111)
				begin
					cicles <= 4'b0000;
					state <= READ_4;
				end
				else
					state <= READ_3;	
			end
			
			READ_4:
			begin
				cicles <= cicles + 4'b0001;
				if(cicles == 4'b1111)
				begin
					cicles <= 4'b0000;
					state <= READ_5;
				end
				else
					state <= READ_4;	
			end
			
			READ_5:
			begin
				cicles <= cicles + 4'b0001;
				if(cicles == 4'b1111)
				begin
					cicles <= 4'b0000;
					state <= READ_6;
				end
				else
					state <= READ_5;	
			end
			
			READ_6:
			begin
				cicles <= cicles + 4'b0001;
				if(cicles == 4'b1111)
				begin
					cicles <= 4'b0000;
					state <= READ_7;
				end
				else
					state <= READ_6;	
			end
			
			READ_7:
			begin
				cicles <= cicles + 4'b0001;
				if(cicles == 4'b1111)
				begin
					cicles <= 4'b0000;
					state <= READ_PARITY;
				end
				else
					state <= READ_7;	
			end
			
			READ_PARITY:
			begin
				cicles <= cicles + 4'b0001;
				if(cicles == 4'b1111)
				begin
					cicles <= 4'b0000;
					state <= FINISH;
				end
				else
					state <= READ_PARITY;
			end
			
			FINISH:
			begin
				cicles <= 4'b0000;
				if(in == 0)
					state <= START;
				else
				begin
					if(clear == 1)
						state <= CLEAR;
					else
						state <= FINISH;
				end
			end
			
			CLEAR:
			begin
				cicles <= 4'b0000;
				if(in == 0)
					state <= START;
				else
					state <= CLEAR;
			end
			
			default:
				state <= INIT;
		endcase
	end
end

always@(*)begin
	case(state)
		INIT:
		begin
			shift_reg = 0;
			load_reg = 1;
			value_reg = 0;
			done_reg = 0;
		end
		
		START:
		begin
			shift_reg = 0;
			load_reg = 1;
			value_reg = 0;
			done_reg = 0;
		end
		
		READ_0:
		begin
			done_reg = 0;
			value_reg = {in,8'b00000000};
			if(cicles == 4'b0111)
				load_reg = 1;	
			else
				load_reg = 0;
			if(cicles == 4'b1000)
				shift_reg = 1;
			else
				shift_reg = 0;
		end
		READ_1:
		begin
			done_reg = 0;
			value_reg = {in,8'b00000000} + shift_out;
			if(cicles == 4'b0111)
				load_reg = 1;	
			else
				load_reg = 0;
			if(cicles == 4'b1000)
				shift_reg = 1;
			else
				shift_reg = 0;
		end
		READ_2:
		begin
			done_reg = 0;
			value_reg = {in,8'b00000000} + shift_out;
			if(cicles == 4'b0111)
				load_reg = 1;	
			else
				load_reg = 0;
			if(cicles == 4'b1000)
				shift_reg = 1;
			else
				shift_reg = 0;
		end
		READ_3:
		begin
			done_reg = 0;
			value_reg = {in,8'b00000000} + shift_out;
			if(cicles == 4'b0111)
				load_reg = 1;	
			else
				load_reg = 0;
			if(cicles == 4'b1000)
				shift_reg = 1;
			else
				shift_reg = 0;
		end
		READ_4:
		begin
			done_reg = 0;
			value_reg = {in,8'b00000000} + shift_out;
			if(cicles == 4'b0111)
				load_reg = 1;	
			else
				load_reg = 0;
			if(cicles == 4'b1000)
				shift_reg = 1;
			else
				shift_reg = 0;
		end
		READ_5:
		begin
			done_reg = 0;
			value_reg = {in,8'b00000000} + shift_out;
			if(cicles == 4'b0111)
				load_reg = 1;	
			else
				load_reg = 0;
			if(cicles == 4'b1000)
				shift_reg = 1;
			else
				shift_reg = 0;
		end
		READ_6:
		begin
			done_reg = 0;
			value_reg = {in,8'b00000000} + shift_out;
			if(cicles == 4'b0111)
				load_reg = 1;	
			else
				load_reg = 0;
			if(cicles == 4'b1000)
				shift_reg = 1;
			else
				shift_reg = 0;
		end
		
		READ_7:
		begin
			done_reg = 0;
			value_reg = {in,8'b00000000} + shift_out;
			if(cicles == 4'b0111)
				load_reg = 1;	
			else
				load_reg = 0;
			if(cicles == 4'b1000)
				shift_reg = 1;
			else
				shift_reg = 0;
		end
		
		READ_PARITY:
		begin
			done_reg = 0;
			shift_reg = 0;
			value_reg = {in,8'b00000000} + shift_out;
			if(cicles == 4'b0111)
				load_reg = 1;	
			else
				load_reg = 0;
//			if(cicles == 4'b1000)
//				shift_reg = 1;
//			else
//				shift_reg = 0;
		end
		
		FINISH:
		begin
			done_reg = 1;
			value_reg = 0;
			shift_reg = 0;
			load_reg = 0;
		end
		
		CLEAR:
		begin
			done_reg = 0;
			value_reg = 0;
			shift_reg = 0;
			load_reg = 1;
		end
		
		default:
		begin
			done_reg = 0;
			value_reg = 0;
			shift_reg = 0;
			load_reg = 0;
		end
	endcase
end

assign shift = shift_reg;
assign load = load_reg;
assign value = value_reg;
assign done = done_reg;

endmodule
