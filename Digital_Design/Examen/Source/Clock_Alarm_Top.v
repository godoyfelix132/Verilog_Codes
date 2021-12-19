module Clock_Alarm_Top
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

wire clk_5Mhz;

clk_pll	clk_pll_inst(
	.inclk0 (clk),
	.c0 (clk_5Mhz)
);

	

Clock_Alarm
Clock_Alarm_1
(
    .clk(clk_5Mhz),
    .reset(reset),
    .Set_Clock(Set_Clock),
	 .MIN(MIN),
	 .HR(HR),
    .Set_Alarm(Set_Alarm),
    .Alarm_Off(Alarm_Off),
//   
    .Alarm_Out(),
    .a_s_u(a_s_u), .b_s_u(b_s_u), .c_s_u(c_s_u), .d_s_u(d_s_u), .e_s_u(e_s_u), .f_s_u(f_s_u), .g_s_u(g_s_u),
    .a_s_t(a_s_t), .b_s_t(b_s_t), .c_s_t(c_s_t), .d_s_t(d_s_t), .e_s_t(e_s_t), .f_s_t(f_s_t), .g_s_t(g_s_t),
    .a_m_u(a_m_u), .b_m_u(b_m_u), .c_m_u(c_m_u), .d_m_u(d_m_u), .e_m_u(e_m_u), .f_m_u(f_m_u), .g_m_u(g_m_u),
    .a_m_t(a_m_t), .b_m_t(b_m_t), .c_m_t(c_m_t), .d_m_t(d_m_t), .e_m_t(e_m_t), .f_m_t(f_m_t), .g_m_t(g_m_t),
    .a_h_u(a_h_u), .b_h_u(b_h_u), .c_h_u(c_h_u), .d_h_u(d_h_u), .e_h_u(e_h_u), .f_h_u(f_h_u), .g_h_u(g_h_u),
    .a_h_t(a_h_t), .b_h_t(b_h_t), .c_h_t(c_h_t), .d_h_t(d_h_t), .e_h_t(e_h_t), .f_h_t(f_h_t), .g_h_t(g_h_t)
	
);



endmodule
