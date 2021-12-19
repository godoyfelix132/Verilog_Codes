module Control
(
	input clk,
	input reset,
	input Alarm_off,
	input Set_Alarm,
	
	input [3:0]hour_unit,
	input [3:0]min_unit,
	input [3:0]seg_unit,
	input [3:0]hour_tens,
	input [3:0]min_tens,
	input [3:0]seg_tens,
	
	input [3:0]hour_al_unit,
	input [3:0]min_al_unit,
	input [3:0]seg_al_unit,
	input [3:0]hour_al_tens,
	input [3:0]min_al_tens,
	input [3:0]seg_al_tens,

	output Alarm_out,
	output change_display
	
	
);

wire [24 : 0]time_actual = {hour_unit, hour_tens, min_unit, min_tens};
wire [24 : 0]time_alarm = {hour_al_unit, hour_al_tens, min_al_unit, min_al_tens};
wire a_wire;
reg a_reg;
reg change_display_reg;
assign a_wire = a_reg;


reg alarm_out_reg = 0
;

always@(posedge clk or negedge reset)begin
	if(reset == 0)
		a_reg <= 0;
	else 
		if(time_actual == time_alarm)
			a_reg <= 1;	
		else
			if(Alarm_off == 1)
				a_reg <= 0;
end

always@(posedge clk or negedge reset)begin
	if(reset == 0)
		alarm_out_reg <= 0;
	else 
		if(a_wire == 1)
			alarm_out_reg <= !alarm_out_reg;	
end

always@(posedge clk or negedge reset)begin
	if(reset == 0)
		change_display_reg <= 0;
	else 
		if(Set_Alarm == 1)
			change_display_reg <= 1;
		else
			change_display_reg <= 0;
end


assign Alarm_out = alarm_out_reg;
assign change_display = change_display_reg;

endmodule
