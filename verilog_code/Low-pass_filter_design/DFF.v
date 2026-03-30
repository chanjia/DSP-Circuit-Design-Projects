module DFF(clk, reset, d, q);
	input clk;
	input reset;
	input [21:0]d;
	output reg [21:0]q;
	
	always@(posedge clk)
	begin
		if(reset)
		begin
			q <= 0;
		end
		else
		begin
			q <= d;
		end
	end	
	
endmodule