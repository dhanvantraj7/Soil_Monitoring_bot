module line_follower(
input clk,
input [11:0] l, r, c,
output reg [1:0] m1, m2
);

//m1-----left
//m2-----right

reg [2:0] node_count = 3'b0;

reg [6:0] counter = 6'b0;
reg [6:0] counter1 = 6'b0;
reg [7:0] DC = 8'b0;
reg S, S1;

always @ (posedge clk)					
begin
	if(counter < 6'd50 )
	begin
		if(counter >= (100)/2)
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
end

always @ (posedge clk)
begin
	if (l>12'd3000 && r>12'd3000 && c>12'd3000)
	begin
		node_count <= node_count + 1'b1;
		if(node_count == 3'd2 || node_count == 3'd5)
		begin
			m2[1] <= (S==1)?0:1;
			m2[0] <= (S==1)?1:0;
			m1[1] <= (S==1)?1:0;
			m1[0] <= (S==1)?0:1;
		end
	end
	else if(l>12'd3000 || (l>12'd3000 && c>12'd3000))
		begin
			m1[1] <= 0;//(S==1)?1:0;
			m1[0] <= 0;//(S==1)?0:1;
			m2[1] <= (S==1)?1:0;
			m2[0] <= (S==1)?0:1;
		end
	else if(r>12'd3000 || (r>12'd3000 && c>12'd3000))
		begin
			m2[1] <= 0;//(S==1)?1:0;
			m2[0] <= 0;//(S==1)?0:1;
			m1[1] <= (S==1)?1:0;
			m1[0] <= (S==1)?0:1;
		end
	else
		begin
			m1[1] <= (S==1)?1:0;
			m1[0] <= (S==1)?0:1;
			m2[1] <= (S==1)?1:0;
			m2[0] <= (S==1)?0:1;
		end
end

endmodule
