// Quartus II Verilog Template
// Single Port ROM

module single_port_rom
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=6)
(
	input [(ADDR_WIDTH-1):0] addr,

	output reg [(DATA_WIDTH-1):0] q
);

	// Declare the ROM variable
	reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];

	// Initialize the ROM with $readmemb.  Put the memory contents
	// in the file single_port_rom_init.txt.  Without this file,
	// this design will not compile.

	initial
	begin
		$readmemb("C:/PADTs/Arquitectura/Practica_2/Source/rom_values_init.txt", rom);
	end

	always @ (q)
	begin
		q = rom[addr];
	end

endmodule
