module Control
#(
    parameter WORD_LENGTH = 5
) 
(
	 input clk,
    input start,
    input reset,
    input [2*WORD_LENGTH-1 : 0] Multiplier,

    output load,
    output shift,
    output value_to_add,
    output clear_product,
    output show_product,
	 output ready

);

localparam INIT = 1;
localparam ASSIGN = 2;
localparam ADD =3;
localparam SHOW = 4;

localparam mask = ({2*WORD_LENGTH{1'b0}} + 1'b1);

reg [2:0] state = 1;

reg load_reg = 1'b0;
reg shift_reg = 1'b0;
reg value_to_add_reg = 1'b0;
reg clear_product_reg = 1'b0;
reg show_product_reg = 1'b0;
reg ready_reg = 1'b0;

reg [4:0]cicles = 1'b0;

always @(posedge clk or negedge reset) 
begin
    if (reset == 1'b0)
    state <= INIT;
    else
    begin
        case(state)
		  
			  INIT:
			  begin
					cicles <= 1'b0;
					if (start == 1'b0)
						state <= ASSIGN;
					else
						state <= INIT;
			  end
			  
			  ASSIGN:
			  begin
						
						state <= ADD;
						
			  end	
			  ADD:
			  begin
					cicles <= cicles + 1'b1;
					if (cicles == 2*WORD_LENGTH)
					begin
						
						state <= SHOW;
					end
					else
						state <= ADD;
				end
					
			  SHOW:
					state <= INIT;		
					
			  default: 
					state <= INIT;
        endcase
    end
end

always @(*) begin
    case(state)
        INIT:
        begin
				show_product_reg = 1'b1;
				clear_product_reg = 1'b0;
				ready_reg = 1'b1;
            load_reg = 1'b0;
            shift_reg = 1'b0;
            value_to_add_reg = 1'b1;            
        end 
        ASSIGN:
        begin
				shift_reg = 1'b0;
				ready_reg = 1'b0;
            load_reg = 1'b1;
				value_to_add_reg = 1'b1; 
            clear_product_reg = 1'b1;  
				show_product_reg = 1'b0;
			
        end
        ADD:
        begin
				show_product_reg = 1'b0;
				ready_reg = 1'b0;
            load_reg = 1'b0;
            clear_product_reg = 1'b0; 
				
				if(Multiplier & mask)
					value_to_add_reg = 1'b1;
				else
					 value_to_add_reg = 1'b0;
					 
            shift_reg = 1'b1;
        end
        SHOW:
        begin
				clear_product_reg = 1'b0;
				value_to_add_reg = 1'b0;
				shift_reg = 1'b1;
				load_reg = 1'b0;
				ready_reg = 1'b1;
            show_product_reg = 1'b1;
            
        end
		  
    endcase
    
end

assign load = load_reg;
assign shift = shift_reg;
assign value_to_add = value_to_add_reg;
assign clear_product = clear_product_reg;
assign show_product = show_product_reg;
assign ready = ready_reg;

endmodule
