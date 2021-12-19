module Block_Decoder
(
	input sel_1,
	input sel_2,
	input [3:0]v_h_unit,
	input [3:0]v_h_tens,

	input [3:0]v_sa_unit,
	input [3:0]v_sa_tens,

	output a_u, b_u, c_u, d_u, e_u, f_u, g_u,
	output a_t, b_t, c_t, d_t, e_t, f_t, g_t
	
);

wire [3:0]out_mux_units_wire;
wire [3:0]out_mux_tens_wire;

Multiplexer_Behavioral
#(
	.WORD_LENGTH(4)
)
Mux_Units
(
	.Selector(sel_1),
	.Data_0(v_h_unit), 
	.Data_1(v_sa_unit),
	
	.Mux_Output(out_mux_units_wire)
); 

Multiplexer_Behavioral
#(
	.WORD_LENGTH(4)
)
Mux_Tens
(
	.Selector(sel_1),
	.Data_0(v_h_tens), 
	.Data_1(v_sa_tens),
	.Mux_Output(out_mux_tens_wire)
); 

Bcd_to_7_seg
Bcd_to_7_seg_units
(
	.bcd(out_mux_units_wire),
		
	.a(a_u), 
	.b(b_u), 
	.c(c_u), 
	.d(d_u), 
	.e(e_u), 
	.f(f_u), 
	.g(g_u)
);

Bcd_to_7_seg
Bcd_to_7_seg_tens
(
	.bcd(out_mux_tens_wire),
		
	.a(a_t), 
	.b(b_t), 
	.c(c_t), 
	.d(d_t), 
	.e(e_t), 
	.f(f_t), 
	.g(g_t)
);

endmodule
