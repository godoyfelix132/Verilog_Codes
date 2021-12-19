module Clock_Alarm
(
    input clk,
    input reset,
    input Set_Clock,
	 input MIN,
	 input HR,
    input Set_Alarm,
    input Alarm_Off,
//   
    output Alarm_Out,
    output a_s_u, b_s_u, c_s_u, d_s_u, e_s_u, f_s_u, g_s_u,
    output a_s_t, b_s_t, c_s_t, d_s_t, e_s_t, f_s_t, g_s_t,
    output a_m_u, b_m_u, c_m_u, d_m_u, e_m_u, f_m_u, g_m_u,
    output a_m_t, b_m_t, c_m_t, d_m_t, e_m_t, f_m_t, g_m_t,
    output a_h_u, b_h_u, c_h_u, d_h_u, e_h_u, f_h_u, g_h_u,
    output a_h_t, b_h_t, c_h_t, d_h_t, e_h_t, f_h_t, g_h_t
	
);


wire [3 : 0]unit_seg_wire;
wire [3 : 0]tens_seg_wire;
wire [3 : 0]unit_min_wire;
wire [3 : 0]tens_min_wire;
wire [3 : 0]unit_hour_wire;
wire [3 : 0]tens_hour_wire;

wire [3 : 0]unit_al_seg_wire;
wire [3 : 0]tens_al_seg_wire;
wire [3 : 0]unit_al_min_wire;
wire [3 : 0]tens_al_min_wire;
wire [3 : 0]unit_al_hour_wire;
wire [3 : 0]tens_al_hour_wire;

wire change_display_reg;

assign unit_al_seg_wire = 4'b0000;
assign tens_al_seg_wire = 4'b0000;

//wire flag;


wire clk_1Mhz_wire;

Clock_Divider
#(
	.FRECUENCY(1),
	.REFERENCE_CLOCK(5000000)
)
clk_1Mhz
(
	.clk_FPGA(clk),
	.reset(reset),
	
	.Clock_Signal(clk_1Mhz_wire)

);

Block_Decoder
Block_Decoder_Seg
(
	.sel_1(change_display_reg),//Control
	.sel_2(change_display_reg),
	
	.v_h_unit(unit_seg_wire),
	.v_h_tens(tens_seg_wire),

	.v_sa_unit(3'b000),
	.v_sa_tens(3'b000),

	.a_u(a_s_u), .b_u(b_s_u), .c_u(c_s_u), .d_u(d_s_u), .e_u(e_s_u), .f_u(f_s_u), .g_u(g_s_u),
	.a_t(a_s_t), .b_t(b_s_t), .c_t(c_s_t), .d_t(d_s_t), .e_t(e_s_t), .f_t(f_s_t), .g_t(g_s_t)
	
);

Block_Decoder
Block_Decoder_Min
(
	.sel_1(change_display_reg),//Control
	.sel_2(change_display_reg),
	
	.v_h_unit(unit_min_wire),
	.v_h_tens(tens_min_wire),

	.v_sa_unit(unit_al_min_wire),
	.v_sa_tens(tens_al_min_wire),

	.a_u(a_m_u), .b_u(b_m_u), .c_u(c_m_u), .d_u(d_m_u), .e_u(e_m_u), .f_u(f_m_u), .g_u(g_m_u),
	.a_t(a_m_t), .b_t(b_m_t), .c_t(c_m_t), .d_t(d_m_t), .e_t(e_m_t), .f_t(f_m_t), .g_t(g_m_t)
	
);

Block_Decoder
Block_Decoder_Hour
(
	.sel_1(change_display_reg),//Control
	.sel_2(change_display_reg),
	
	.v_h_unit(unit_hour_wire),
	.v_h_tens(tens_hour_wire),

	.v_sa_unit(unit_al_hour_wire),
	.v_sa_tens(tens_al_hour_wire),

	.a_u(a_h_u), .b_u(b_h_u), .c_u(c_h_u), .d_u(d_h_u), .e_u(e_h_u), .f_u(f_h_u), .g_u(g_h_u),
	.a_t(a_h_t), .b_t(b_h_t), .c_t(c_h_t), .d_t(d_h_t), .e_t(e_h_t), .f_t(f_h_t), .g_t(g_h_t)
	
);

Block_Time
Block_Time_1
(
	.clk(clk_1Mhz_wire),
	.reset(reset),
	.enable(1'b1),
	.Set_clock(Set_Clock),
	.HR(HR),
	.MIN(MIN),
	
	
	.unit_seg(unit_seg_wire), 
	.tens_seg(tens_seg_wire), 
	.unit_min(unit_min_wire), 
	.tens_min(tens_min_wire), 
	.unit_hour(unit_hour_wire), 
	.tens_hour(tens_hour_wire)
//	.flag(flag)
);

Block_Alarm
Block_Alarm_1
(
	.clk(clk_1Mhz_wire),
	.reset(reset),
	.Set_Alarm(Set_Alarm),
	.MIN(MIN),
	.HR(HR),
	
	.unit_min(unit_al_min_wire), 
	.tens_min(tens_al_min_wire), 
	.unit_hour(unit_al_hour_wire), 
	.tens_hour(tens_al_hour_wire)

);


Control
Control_1
(
	.clk(clk_1Mhz_wire),
	.reset(reset),
	.Alarm_off(Alarm_Off),
	.Set_Alarm(Set_Alarm),
	
	.hour_unit(unit_hour_wire),
	.min_unit(unit_min_wire),
	.seg_unit(unit_seg_wire),
	.hour_tens(tens_hour_wire),
	.min_tens(tens_min_wire),
	.seg_tens(tens_seg_wire),
	
	.hour_al_unit(unit_al_hour_wire),
	.min_al_unit(unit_al_min_wire),
	.seg_al_unit(unit_al_seg_wire),
	.hour_al_tens(tens_al_hour_wire),
	.min_al_tens(tens_al_min_wire),
	.seg_al_tens(tens_al_seg_wire),
	
	.change_display(change_display_reg),
	.Alarm_out(Alarm_Out)
	
);


endmodule

