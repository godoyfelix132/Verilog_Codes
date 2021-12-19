module UART_sentData
(
	input wire clk,  
   input wire dtr,  //-- Señal de DTR
	input [7:0] mesage_tx,
	input wire rstn,
   
	output wire tx
);

localparam IDLE = 0;   		//Reposo
localparam TXCAR = 2'd1;  	//Transmitiendo caracter
localparam NEXT = 2'd2;   	//Preparar transmision del sig caracter
localparam END = 3;    		//Terminar

reg [1:0] state;
reg [7:0] data;
reg [7:0] data_r;
//-- Señal para indicar al controlador el comienzo de la transmision (DTR registrada)
reg transmit;
reg cena;      //Habilita el contador cuando es 1
reg start;
reg [2:0] car_count;

wire ready;

UART_TX
UART_TX0 
(
	.clk_baud(clk),
   .rstn(rstn),
   .data(data),
   .start(start),
	
   .ready(ready),
   .tx(tx)
);


//Multiplexor con los caracteres de la cadena a transmitir
always @*
  case (car_count)
	 8'd0: data <= mesage_tx;
    default: data <= 0;
  endcase

//-- Registrar los datos de salida del multiplexor
always@(*) begin
  data_r <= data;
end


always @(posedge clk) begin
  if (rstn == 0)
    car_count = 0;
  else if (cena)
    car_count = car_count + 1;
end

//-- Registrar señal dtr (Inicio de la transmicion)
always @(posedge clk) begin
  transmit <= dtr;
end


always @(posedge clk) begin
	if(rstn == 0) begin
    state <= IDLE;
	end
	else begin
		case (state)
			IDLE: begin
				if(transmit == 1) begin
					state <= TXCAR;
				end
				else begin
					state <= IDLE;
				end
			end

			TXCAR: begin
				if(ready == 1) begin
					state <= END;
				end
				else begin
					state <= TXCAR;
				end
			end

			NEXT:	
				if(car_count == 1) begin
					state <= END;
				end
				else begin
					state <= TXCAR;
				end
			END: 
				if(ready == 1) begin
					state <= IDLE;
				end
				else begin
					state <= END;
				end
			default:
				state <= IDLE;
		endcase
	end
end


always@(*) begin
  case (state)
    IDLE: begin
      start <= 0;
      cena <= 0;
    end

    TXCAR: begin
      start <= 1;
      cena <= 0;
    end

    NEXT: begin
      start <= 0;
      cena <= 1;
    end

    END: begin
      start <= 0;
      cena <= 0;
    end

    default: begin
      start <= 0;
      cena <= 0;
    end
  endcase
end

endmodule
