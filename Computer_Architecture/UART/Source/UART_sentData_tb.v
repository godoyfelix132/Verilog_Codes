
module UART_sentData_tb();

localparam BAUD = 5208;
localparam BITRATE = (BAUD << 1);
localparam FRAME = (BITRATE * 11);
localparam FRAME_WAIT = (BITRATE * 4);

reg clk = 0;
wire tx;
reg dtr = 0;

UART_sentData
dut
(
    .clk(clk),
    .dtr(dtr),
    .tx(tx)
);

always 
  # 1 clk <= ~clk;


initial begin

  #1 dtr <= 0;

  //-- Comenzar primer envio
  #FRAME_WAIT dtr <= 1;
  #(BITRATE * 2) dtr <=0;

  //-- Segundo envio (2 caracteres mas)
  #(FRAME * 11) dtr <=1;
  #(BITRATE * 1) dtr <=0;

  #(FRAME * 11);
end

endmodule
