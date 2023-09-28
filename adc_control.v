// SM : Task 2 A : ADC
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design ADC Controller.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//ADC Controller design
//Inputs  : clk_50 : 50 MHz clock, dout : digital output from ADC128S022 (serial 12-bit)
//Output  : adc_cs_n : Chip Select, din : Ch. address input to ADC128S022, adc_sck : 2.5 MHz ADC clock,
//				d_out_ch5, d_out_ch6, d_out_ch7 : 12-bit output of ch. 5,6 & 7,
//				data_frame : To represent 16-cycle frame (optional)

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module adc_control(
	input  clk_50,				//50 MHz clock
	input  dout,				//digital output from ADC128S022 (serial 12-bit)
	output adc_cs_n,			//ADC128S022 Chip Select
	output din,					//Ch. address input to ADC128S022 (serial)
	output adc_sck,			//2.5 MHz ADC clock
	output [11:0]d_out_ch5,	//12-bit output of ch. 5 (parallel)
	output [11:0]d_out_ch6,	//12-bit output of ch. 6 (parallel)
	output [11:0]d_out_ch7,	//12-bit output of ch. 7 (parallel)
	output [1:0]data_frame	//To represent 16-cycle frame (optional)
);
	
////////////////////////WRITE YOUR CODE FROM HERE////////////////////

reg [4:0] counter_clk_50 = 5'b0;
reg out;

always @ (negedge clk_50)					
	begin
		if(counter_clk_50 <= 5'b10011)
			begin
				if(counter_clk_50 >= 10)
					begin
					counter_clk_50 = counter_clk_50 + 1'b1;
					out = 1;
					end
				else
					begin
					counter_clk_50 = counter_clk_50 + 1'b1;
					out = 0;
					end
			end	
		else
			begin
			counter_clk_50 = 1'b1;
			out = 0;
			end
	end
assign adc_sck = (out == 1) ? 1'b1:1'b0;


reg din_out;
reg [11:0] ch;
reg [5:0] counter_din = 12'b0;
reg [1:0] counter_dataframe = 2'b11;

reg addr2 = 1;
reg addr1 = 0;
reg addr0 = 1;


reg [11:0] data = 12'b0;
reg adc_cs = 1;
reg [11:0] channel5 = 12'b0;
reg [11:0] channel6 = 12'b0;
reg [11:0] channel7 = 12'b0;

always @ (negedge adc_sck)
begin
adc_cs = 0;
	case (counter_din)
	6'd0		: begin
				   din_out <= 0;
					
					if(counter_dataframe < 2'b11)
					begin
						if(counter_dataframe == 2'b00)
						begin
							addr2 <= 1;
							addr1 <= 1;
							addr0 <= 0;
							counter_dataframe <= counter_dataframe + 1'b1;
						end
						else if(counter_dataframe == 2'b01)
						begin
							addr2 <= 1;
							addr1 <= 1;
							addr0 <= 1;
							counter_dataframe <= counter_dataframe + 1'b1;
						end
						else if(counter_dataframe == 2'b10)
						begin
							addr2 <= 1;
							addr1 <= 0;
							addr0 <= 1;
							counter_dataframe <= 2'b00;
						end
					end
					else
						counter_dataframe <= 2'b00;
						
					ch <= data;
					counter_din <= counter_din + 1'b1;
				  end
	
	6'd1		: begin
					din_out <= 0;
				   counter_din <= counter_din + 1'b1;
				  end
	
	6'd2		: begin
					din_out <= addr2;
					counter_din <= counter_din + 1'b1;
				  end
				  
	6'd3		: begin
					din_out <= addr1;
					counter_din <= counter_din + 1'b1;
				  end
	
	6'd4		: begin
					din_out <= addr0;
					counter_din <= counter_din + 1'b1;
				  end
	
	6'd5		: begin
					counter_din <= counter_din + 1'b1;
				   din_out <= 0;
				  end
	
	6'd6		: begin
					din_out <= 0;
					counter_din <= counter_din + 1'b1;
				  end
	
	6'd7		: begin
					din_out <= 0;
					counter_din <= counter_din + 1'b1;
				  end
				  
	6'd8		: begin
					din_out <= 0;
					counter_din <= counter_din + 1'b1;
				  end
				  
	6'd9		: begin
					din_out <= 0;
					counter_din <= counter_din + 1'b1;
				  end
				  
	6'd10	: begin
					din_out <= 0;
					counter_din <= counter_din + 1'b1;
				  end
				  
	6'd11	: begin
					din_out <= 0;
					counter_din <= counter_din + 1'b1;
				  end
				  
	6'd12	: begin
					din_out <= 0;
					counter_din <= counter_din + 1'b1;
				  end
				  
	6'd13	: begin
					din_out <= 0;
					counter_din <= counter_din + 1'b1;
				  end
				  
	6'd14	: begin
					din_out <= 0;
					counter_din <= counter_din + 1'b1;
				  end
				  
	6'd15	: begin
					din_out <= 0;
					counter_din <= 12'b0;
				  end
				  
	default	: begin
				   din_out <= 0;
				  end
	endcase
end
assign adc_cs_n  = adc_cs;
assign data_frame = counter_dataframe;
assign din = din_out;


reg [11:0] counter_cycle = 12'b0;



always @ (posedge adc_sck)
begin
	
	case (counter_cycle)
	12'd0		: begin
					counter_cycle <= counter_cycle + 1'b1;
				  end

	12'd1		: begin
					counter_cycle <= counter_cycle + 1'b1;
				  end
	
	12'd2		: begin
					counter_cycle <= counter_cycle + 1'b1;
				  end
	
	12'd3		: begin
					counter_cycle <= counter_cycle + 1'b1;
				  end
			
	12'd4		: begin
					data[11] <= dout;
					counter_cycle <= counter_cycle + 1'b1;
				  end
	
	12'd5		: begin
					data[10] <= dout;
					counter_cycle <= counter_cycle + 1'b1;
				  end
	
	12'd6		: begin
					data[9] <= dout;
					counter_cycle <= counter_cycle + 1'b1;
				  end
				  
	12'd7		: begin
					data[8] <= dout;
					counter_cycle <= counter_cycle + 1'b1;
				  end
				  
	12'd8		: begin
					data[7] <= dout;
					counter_cycle <= counter_cycle + 1'b1;
				  end
	
	12'd9		: begin
					data[6] <= dout;
					counter_cycle <= counter_cycle + 1'b1;
				  end
	
	12'd10	: begin
					data[5] <= dout;
					counter_cycle <= counter_cycle + 1'b1;
				  end
	
	12'd11	: begin
					data[4] <= dout;
					counter_cycle <= counter_cycle + 1'b1;
				  end
	12'd12	: begin
					data[3] <= dout;
					counter_cycle <= counter_cycle + 1'b1;
				  end
	12'd13	: begin
					data[2] <= dout;
					counter_cycle <= counter_cycle + 1'b1;
				  end
	12'd14	: begin
					data[1] <= dout;
					counter_cycle <= counter_cycle + 1'b1;
				  end
	12'd15	: begin
					data[0] <= dout;
					counter_cycle <= 12'd0;
				  end
	
	default  : begin
					counter_cycle <= 12'd0;
				  end
	endcase
end

always @ (negedge adc_sck)
begin
	if(counter_dataframe == 2'b10)
		channel5 <= ch;
	else if(counter_dataframe == 2'b00)
		channel6 <= ch;
	else if(counter_dataframe == 2'b01)
		channel7 <= ch;
	else
	begin
		channel5 = 0;
		channel6 = 0;
		channel7 = 0;
	end
end


assign d_out_ch5 = channel5;
assign d_out_ch6 = channel6;
assign d_out_ch7 = channel7;

////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////