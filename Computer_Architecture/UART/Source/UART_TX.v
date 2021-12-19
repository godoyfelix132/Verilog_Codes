
module UART_TX
(
	input clk_baud,
	input rstn,
	input start,
	input [7:0] data,
	
	output reg tx,
	output ready
);

localparam IDLE = 0;		//estado en reposo
localparam START = 1;	//Comienzo de la transmicion
localparam TRANS = 2;	//Transmitiendo dato

reg [1:0] state;	//Estado del controlador

reg start_r;		//Señal de start registrada
reg [3:0] bitc;	//contador de bits del registro de entrada
reg [7:0] data_r;	//Datos registrados

//wire clk_baud;		//Reloj para la transmision
wire load;			
wire baud_en;
wire parity;

reg [10:0] shifter;	//1 bit start + 8 bit datos + 1 bit paridad + 1 bit stop



//baudgen
//baudgen0
//(
//	.clk(clk),
//	.clk_ena(baud_en),
//	
//	.clk_out(clk_baud)
//);


Parity_Check
Parity_Check0
(
	.d(data),
	.parity(1),
	.enable(1),
	
	.result(parity)
);


/***************RUTA DE DATOS*************************************************/
always@(posedge clk_baud) begin
	start_r = start;
end

always@(posedge clk_baud) begin
	if(start == 1 && state == IDLE) begin
		data_r = data;
	end
end


always@(posedge clk_baud) begin
	if(rstn == 0) begin
		shifter = 10'b11_1111_1111; 
	end
	
	else if(load == 1) begin
		shifter = {data_r,2'b01};
	end
	
	else if(load == 0 && clk_baud == 1) begin
		shifter = {1'b1, parity, shifter[10:1]};
	end
end

always@(posedge clk_baud) begin
	if(load == 1) begin
		bitc = 0;
	end
	
	else if(load == 0 && clk_baud == 1) begin
		bitc = bitc + 1;
	end
end

always@(posedge clk_baud) begin
	tx = shifter[0];
end


/**************CONTROLADOR******************************************************/
always@(posedge clk_baud) begin
	if(rstn == 0) begin
		state <= IDLE;
	end
	else begin
		case(state)
			IDLE: begin
				if(start_r == 1) begin
					state = START;
				end
				else begin
					state = IDLE;
				end
			end
			
			START: begin
				state = TRANS;
			end
			
			TRANS: begin
				if(bitc == 11) begin
					state = IDLE;
				end
				else begin
					state = TRANS;
				end
			end
			
			default:
				state = IDLE;
		endcase
	end
end


assign load = (state == START) ? 1 : 0;
assign baud_en = (state == IDLE) ? 0 : 1;

assign ready = (state == IDLE) ? 1 : 0;


endmodule
