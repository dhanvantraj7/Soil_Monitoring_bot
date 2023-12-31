// SM : Task 1 A : Combinational Circuit
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design 2 bit comparator.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
			Do not make any changes to Test_Bench_Vector.txt file. Violating will result into Disqualification.
-------------------
*/

//2 bit comparator design
//Inputs  : A and B (2 bit)
//Outputs : A_Greater (A>B), Equal (A=B), B_Greater (A<B)

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module Two_Bit_Comparator(
	input		[1:0]A,           //2-bit INPUT A
	input		[1:0]B,				//2-bit INPUT B				
	output	A_Greater,			//OUTPUT BIT A>B
	output	Equal,				//OUTPUT BIT A=B
	output	B_Greater			//OUTPUT BIT A<B
);

////////////////////////WRITE YOUR CODE FROM HERE////////////////////
 
	assign A_Greater = (A[1]&!B[1]) | (A[0]&!B[1]&!B[0]) | (A[1]&A[0]&!B[0]);
	assign Equal = (A[0] ^~ B[0]) & (A[1] ^~ B[1]);
	assign B_Greater = (!A[1]&B[1]) | (!A[0]&B[1]&B[0]) | (!A[1]&!A[0]&B[0]);
	
////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////