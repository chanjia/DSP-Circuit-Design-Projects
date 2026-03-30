 module half_adder(A, B, Sum, Cout);
 
	input A, B;
	output Sum,	Cout;

	assign Sum = A ^ B;
	assign Cout = A & B;
  
  endmodule