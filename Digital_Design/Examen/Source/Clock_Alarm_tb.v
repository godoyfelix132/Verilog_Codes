/**************************************************************************************
*	Description
*		This is the tb for a sequential multiplier
*		1.0
*	Author:
*		Ing. Félix Godoy Martínez
*	Date:
*		14/07/20
***************************************************************************************/

/*`timescale <time_unit>/<time_precision>*/
`timescale 1ns/1ns 


module Clock_Alarm_tb;

//parameter WORD_LENGTH = 5;

reg clk_tb = 0;
reg reset_tb = 0;
reg Set_clock_tb = 0;
reg Set_Alarm_tb = 0;
reg Alarm_Off_tb = 0;
reg MIN_tb = 0;
reg HR_tb = 0;

wire a_s_u_tb, b_s_u_tb, c_s_u_tb, d_s_u_tb, e_s_u_tb, f_s_u_tb, g_s_u_tb;
wire a_s_t_tb, b_s_t_tb, c_s_t_tb, d_s_t_tb, e_s_t_tb, f_s_t_tb, g_s_t_tb;
wire a_m_u_tb, b_m_u_tb, c_m_u_tb, d_m_u_tb, e_m_u_tb, f_m_u_tb, g_m_u_tb;
wire a_m_t_tb, b_m_t_tb, c_m_t_tb, d_m_t_tb, e_m_t_tb, f_m_t_tb, g_m_t_tb;
wire a_h_u_tb, b_h_u_tb, c_h_u_tb, d_h_u_tb, e_h_u_tb, f_h_u_tb, g_h_u_tb;
wire a_h_t_tb, b_h_t_tb, c_h_t_tb, d_h_t_tb, e_h_t_tb, f_h_t_tb, g_h_t_tb;

Clock_Alarm
DUV
(
	.clk(clk_tb),
	.reset(reset_tb),
	.Set_Clock(Set_clock_tb),
	.Set_Alarm(Set_Alarm_tb),
	.Alarm_Off(Alarm_Off_tb),
	.MIN(MIN_tb),
	.HR(HR_tb),
	
	.a_s_u(a_s_u_tb), .b_s_u(b_s_u_tb), .c_s_u(c_s_u_tb), .d_s_u(d_s_u_tb), .e_s_u(e_s_u_tb), .f_s_u(f_s_u_tb), .g_s_u(g_s_u_tb),
	.a_s_t(a_s_t_tb), .b_s_t(b_s_t_tb), .c_s_t(c_s_t_tb), .d_s_t(d_s_t_tb), .e_s_t(e_s_t_tb), .f_s_t(f_s_t_tb), .g_s_t(g_s_t_tb),
	.a_m_u(a_m_u_tb), .b_m_u(b_m_u_tb), .c_m_u(c_m_u_tb), .d_m_u(d_m_u_tb), .e_m_u(e_m_u_tb), .f_m_u(f_m_u_tb), .g_m_u(g_m_u_tb),
	.a_m_t(a_m_t_tb), .b_m_t(b_m_t_tb), .c_m_t(c_m_t_tb), .d_m_t(d_m_t_tb), .e_m_t(e_m_t_tb), .f_m_t(f_m_t_tb), .g_m_t(g_m_t_tb),
	.a_h_u(a_h_u_tb), .b_h_u(b_h_u_tb), .c_h_u(c_h_u_tb), .d_h_u(d_h_u_tb), .e_h_u(e_h_u_tb), .f_h_u(f_h_u_tb), .g_h_u(g_h_u_tb),
	.a_h_t(a_h_t_tb), .b_h_t(b_h_t_tb), .c_h_t(c_h_t_tb), .d_h_t(d_h_t_tb), .e_h_t(e_h_t_tb), .f_h_t(f_h_t_tb), .g_h_t(g_h_t_tb)
);

initial begin
	forever #10 clk_tb = !clk_tb;
end

initial begin
	#0 reset_tb = 0;
	#40 reset_tb = 1;
end

initial begin
	#0 Alarm_Off_tb = 0;
	#4989957 Alarm_Off_tb = 1;
end

//initial begin
//	#0 Set_Alarm_tb = 0;
//	#200 Set_Alarm_tb = 0;
//	#1000 Set_Alarm_tb = 1;
//	#8000 Set_Alarm_tb = 0;
//	#200 Set_Alarm_tb = 1;	
//end 
//
//initial begin
//	#0 MIN_tb = 0;
//	#20 MIN_tb = 1;
//end 
//initial begin
//	#0 HR_tb = 0;
//	#20 HR_tb = 1;
//end 


endmodule
