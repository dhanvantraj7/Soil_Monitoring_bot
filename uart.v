// SM : Task 2 B : UART
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design UART Transmitter.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be  on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//UART Transmitter design
//Input   : clk_50M : 50 MHz clock
//Output  : tx : UART transmit output

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module uart(
	input clk_50M,	//50 MHz clock
	output tx		//UART transmit output
);
////////////////////////WRITE YOUR CODE FROM HERE////////////////////

reg [8:0] counter = 9'b0;
reg S;
wire clk_out;

reg [2:0] cur_state, next_state;
reg [7:0] data;
reg [2:0] data_counter = 3'b0;
reg [4:0] bit_counter = 5'b0;

reg [7:0] ASCII_S = 8'b11001010;
reg [7:0] ASCII_M = 8'b10110010;
reg [7:0] ASCII_1 = 8'b10001100;
reg [7:0] ASCII_6 = 8'b01101100;

reg tx_out;

parameter IDLE = 0; 
parameter START_BIT = 1;
parameter DATA_BITS = 2;
parameter STOP_BIT = 3;

always @ (posedge clk_50M)					
	begin
		if(counter < 434 )
			begin
				if(counter >= 217)
					begin
					counter = counter + 1'b1;
					S = 0;
					end
				else
					begin
					counter = counter + 1'b1;
					S = 1;
					end
			end	
		else
			begin
			counter = 1'b1;
			S = 1;
			end
		begin
		cur_state <= next_state;
		end
	end
	
assign clk_out = (S==1) ? 1'b1:1'b0;

initial 
	begin 
	cur_state = IDLE;
	next_state = 0;
	end

always @(posedge clk_out)
	begin
		case (cur_state)
					 
	IDLE : 
			begin
			tx_out = 1'b1;
			data = 8'b0;
			data_counter <= 3'b111;
				
				if (bit_counter == 0) 
					begin 
					data = ASCII_S; 
					next_state = START_BIT;
					end
					
				else if (bit_counter == 1) 
					begin
					data = ASCII_M;
					next_state = START_BIT;
					end
					
				else if (bit_counter == 2) 
					begin
					data = ASCII_1;
					next_state = START_BIT;
					end
					
				else if (bit_counter == 3) 
					begin
					data = ASCII_6;
					next_state = START_BIT;
					end
					
				else 
					begin  
				next_state = STOP_BIT;
					end
			end
      
   START_BIT : 
			begin 
			tx_out = 1'b0;
			next_state = DATA_BITS;
			end 
	
	DATA_BITS : 
			begin
			tx_out = (data[data_counter]);
			
			if (data_counter == 0) 
				begin
				data_counter <= 3'b111;
				next_state = STOP_BIT;
				end
			else
				begin
				data_counter <= data_counter - 3'b001;
				next_state = DATA_BITS;
				end
			end

	STOP_BIT : 
			begin
			tx_out = 1'b1;
			data = 8'b0;
			bit_counter <= bit_counter + 5'b0001;
			next_state = IDLE;
			end

		endcase
	end

assign tx = tx_out ? 1'b1:1'b0;

////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////
