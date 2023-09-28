// SM : Task 1 C : Finite State Machine
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a Finite State Machine.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
			Do not make any changes to Test_Bench_Vector.txt file. Violating will result into Disqualification.
-------------------
*/

//Finite State Machine design
//Inputs  : I (4 bit) and CLK (clock)
//Output  : Y (Y = 1 when 1094 sequence(decimal number sequence) is detected)

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module fsm(
	input CLK,			  //Clock
	input [3:0]I,       //INPUT I
	output	  Y		  //OUTPUT Y
);

////////////////////////WRITE YOUR CODE FROM HERE//////////////////// 
	

// Tip : Write your code such that Quartus Generates a State Machine 
//			(Tools > Netlist Viewers > State Machine Viewer).
// 		For doing so, you will have to properly declare State Variables of the
//       State Machine and also perform State Assignments correctly.
//			Use Verilog case statement to design.
	
parameter IDLE = 0, S1 = 1, S10 = 2, S109 = 3, S1094 = 4;

reg[2:0] cur_state, next_state;

assign Y = cur_state == S1094 ? 1:0;
always @(posedge CLK)
begin
cur_state <= next_state;
end

initial begin cur_state = 0;
next_state = 0;
end

always @(cur_state or I)
begin
case (cur_state)
IDLE : begin
if (I == 4'b0001) next_state = S1;
else next_state = IDLE;
end

S1 : begin 
if (I == 4'b0000) next_state = S10;
else if(I == 4'b0001)
     next_state = S1;
else next_state = IDLE;
end

S10 : begin 
if (I == 4'b1001) next_state = S109;
else if(I == 4'b0001)
     next_state = S1;
else next_state = IDLE;
end

S109 : begin 
if (I == 4'b0100) next_state = S1094;
else if(I == 4'b0001)
     next_state = S1;
else next_state = IDLE;
end

S1094 : begin 
if(I == 4'b0001)
     next_state = S1;
else	  
next_state = IDLE;
end
endcase
end	

////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////