module multiply #(parameter A_WIDTH=6, B_WIDTH=8)(A, B, P); // P=A*B
	//Baugh-Wooley multiplier based on Wallace-tree carry-save-addition (CSA) architecture.
	
	input [(A_WIDTH-1):0] A;
	input [(B_WIDTH-1):0] B;
	output [(A_WIDTH+B_WIDTH-1):0] P;
	
	//Generate products 
	wire [B_WIDTH-1:0]AB[A_WIDTH-1:0]; 	

	genvar i;
	generate	
		for(i=0;i<A_WIDTH-1;i=i+1)
		begin: partial_products
			assign AB[i] = A[i] ? {~B[B_WIDTH-1],B[B_WIDTH-2:0]}:{1'b1,{(B_WIDTH-1){1'b0}}};
		end
	endgenerate
	assign AB[A_WIDTH-1] = A[A_WIDTH-1]?{B[B_WIDTH-1],~(B[B_WIDTH-2:0])}:{1'b0,{(B_WIDTH-1){1'b1}}};
	
	//stage 1
	wire [7:0] S1, C1;
	wire [7:0] S2, C2;
	
	half_adder ha1_stage1(.A(AB[0][1]), .B(AB[1][0]), .Sum(S1[0]), .Cout(C1[0]));
	full_adder fa1_stage1(.A(AB[0][2]), .B(AB[1][1]), .Cin(AB[2][0]), .Sum(S1[1]), .Cout(C1[1]));
	full_adder fa2_stage1(.A(AB[0][3]), .B(AB[1][2]), .Cin(AB[2][1]), .Sum(S1[2]), .Cout(C1[2]));
	full_adder fa3_stage1(.A(AB[0][4]), .B(AB[1][3]), .Cin(AB[2][2]), .Sum(S1[3]), .Cout(C1[3]));
	full_adder fa4_stage1(.A(AB[0][5]), .B(AB[1][4]), .Cin(AB[2][3]), .Sum(S1[4]), .Cout(C1[4]));
	full_adder fa5_stage1(.A(AB[0][6]), .B(AB[1][5]), .Cin(AB[2][4]), .Sum(S1[5]), .Cout(C1[5]));
	full_adder fa6_stage1(.A(AB[0][7]), .B(AB[1][6]), .Cin(AB[2][5]), .Sum(S1[6]), .Cout(C1[6])); 
	half_adder ha2_stage1(.A(AB[1][7]), .B(AB[2][6]), .Sum(S1[7]), .Cout(C1[7]));

	half_adder ha3_stage1 (.A(AB[3][1]), .B(AB[4][0]), .Sum(S2[0]), .Cout(C2[0]));
	full_adder fa7_stage1 (.A(AB[3][2]), .B(AB[4][1]), .Cin(AB[5][0]), .Sum(S2[1]), .Cout(C2[1]));
	full_adder fa8_stage1 (.A(AB[3][3]), .B(AB[4][2]), .Cin(AB[5][1]), .Sum(S2[2]), .Cout(C2[2]));
	full_adder fa9_stage1 (.A(AB[3][4]), .B(AB[4][3]), .Cin(AB[5][2]), .Sum(S2[3]), .Cout(C2[3]));
	full_adder fa10_stage1(.A(AB[3][5]), .B(AB[4][4]), .Cin(AB[5][3]), .Sum(S2[4]), .Cout(C2[4]));
	full_adder fa11_stage1(.A(AB[3][6]), .B(AB[4][5]), .Cin(AB[5][4]), .Sum(S2[5]), .Cout(C2[5]));
	full_adder fa12_stage1(.A(AB[3][7]), .B(AB[4][6]), .Cin(AB[5][5]), .Sum(S2[6]), .Cout(C2[6])); 
	half_adder ha4_stage1 (.A(AB[4][7]), .B(AB[5][6]), .Sum(S2[7]), .Cout(C2[7]));
	
	//stage 2
	wire [7:0] S3, C3;
	
	half_adder ha1_stage2(.A(C1[0]), .B(S1[1]), .Sum(S3[0]), .Cout(C3[0]));
	full_adder fa1_stage2(.A(C1[1]), .B(S1[2]), .Cin(AB[3][0]), .Sum(S3[1]), .Cout(C3[1]));
	full_adder fa2_stage2(.A(C1[2]), .B(S1[3]), .Cin(S2[0]), .Sum(S3[2]), .Cout(C3[2]));
	full_adder fa3_stage2(.A(C1[3]), .B(S1[4]), .Cin(S2[1]), .Sum(S3[3]), .Cout(C3[3]));
	full_adder fa4_stage2(.A(C1[4]), .B(S1[5]), .Cin(S2[2]), .Sum(S3[4]), .Cout(C3[4]));
	full_adder fa5_stage2(.A(C1[5]), .B(S1[6]), .Cin(S2[3]), .Sum(S3[5]), .Cout(C3[5]));
	full_adder fa6_stage2(.A(C1[6]), .B(S1[7]), .Cin(S2[4]), .Sum(S3[6]), .Cout(C3[6])); 
	full_adder fa7_stage2(.A(C1[7]), .B(S2[5]), .Cin(AB[2][7]), .Sum(S3[7]), .Cout(C3[7])); 
	
	//stage 3
	wire [9:0] S4, C4;
	
	half_adder ha1_stage3(.A(C3[0]), .B(S3[1]), .Sum(S4[0]), .Cout(C4[0]));
	half_adder ha2_stage3(.A(C3[1]), .B(S3[2]), .Sum(S4[1]), .Cout(C4[1]));
	full_adder fa1_stage3(.A(C3[2]), .B(S3[3]), .Cin(C2[0]), .Sum(S4[2]), .Cout(C4[2]));
	full_adder fa2_stage3(.A(C3[3]), .B(S3[4]), .Cin(C2[1]), .Sum(S4[3]), .Cout(C4[3]));
	full_adder fa3_stage3(.A(C3[4]), .B(S3[5]), .Cin(C2[2]), .Sum(S4[4]), .Cout(C4[4]));
	full_adder fa4_stage3(.A(C3[5]), .B(S3[6]), .Cin(C2[3]), .Sum(S4[5]), .Cout(C4[5]));
	full_adder fa5_stage3(.A(C3[6]), .B(S3[7]), .Cin(C2[4]), .Sum(S4[6]), .Cout(C4[6]));
	full_adder fa6_stage3(.A(C3[7]), .B(S2[6]), .Cin(C2[5]), .Sum(S4[7]), .Cout(C4[7])); 
	half_adder ha3_stage3(.A(S2[7]), .B(C2[6]), .Sum(S4[8]), .Cout(C4[8]));
	half_adder ha4_stage3(.A(C2[7]), .B(AB[5][7]), .Sum(S4[9]), .Cout(C4[9]));
	
	//stage 4
	wire [9:0] S5, C5;
	
	half_adder ha1_stage4(.A(C4[0]), .B(S4[1]), .Sum(S5[0]), .Cout(C5[0]));
	full_adder fa1_stage4(.A(C4[1]), .B(S4[2]), .Cin(1'b1), .Sum(S5[1]), .Cout(C5[1]));
	half_adder ha2_stage4(.A(C4[2]), .B(S4[3]), .Sum(S5[2]), .Cout(C5[2]));
	full_adder fa2_stage4(.A(C4[3]), .B(S4[4]), .Cin(1'b1), .Sum(S5[3]), .Cout(C5[3]));
	half_adder ha3_stage4(.A(C4[4]), .B(S4[5]), .Sum(S5[4]), .Cout(C5[4]));
	half_adder ha4_stage4(.A(C4[5]), .B(S4[6]), .Sum(S5[5]), .Cout(C5[5]));
	half_adder ha5_stage4(.A(C4[6]), .B(S4[7]), .Sum(S5[6]), .Cout(C5[6]));
	half_adder ha6_stage4(.A(C4[7]), .B(S4[8]), .Sum(S5[7]), .Cout(C5[7]));
	half_adder ha7_stage4(.A(C4[8]), .B(S4[9]), .Sum(S5[8]), .Cout(C5[8]));
	half_adder ha8_stage4(.A(C4[9]), .B(1'b1), .Sum(S5[9]), .Cout(C5[9]));
	
	//stage 5
	wire [8:0] C6;
	
	half_adder ha1_stage5(.A(C5[0]), .B(S5[1]), .Sum(P[5]), .Cout(C6[0]));
	full_adder fa1_stage5(.A(C5[1]), .B(S5[2]), .Cin(C6[0]), .Sum(P[6 ]), .Cout(C6[1]));
	full_adder fa2_stage5(.A(C5[2]), .B(S5[3]), .Cin(C6[1]), .Sum(P[7 ]), .Cout(C6[2]));
	full_adder fa3_stage5(.A(C5[3]), .B(S5[4]), .Cin(C6[2]), .Sum(P[8 ]), .Cout(C6[3]));
	full_adder fa4_stage5(.A(C5[4]), .B(S5[5]), .Cin(C6[3]), .Sum(P[9 ]), .Cout(C6[4]));
	full_adder fa5_stage5(.A(C5[5]), .B(S5[6]), .Cin(C6[4]), .Sum(P[10]), .Cout(C6[5]));
	full_adder fa6_stage5(.A(C5[6]), .B(S5[7]), .Cin(C6[5]), .Sum(P[11]), .Cout(C6[6])); 
	full_adder fa7_stage5(.A(C5[7]), .B(S5[8]), .Cin(C6[6]), .Sum(P[12]), .Cout(C6[7]));
	full_adder fa8_stage5(.A(C5[8]), .B(S5[9]), .Cin(C6[7]), .Sum(P[13]), .Cout(C6[8]));
	
	assign P[0] = AB[0][0];
	assign P[1] = S1[0];
	assign P[2] = S3[0];
	assign P[3] = S4[0];
	assign P[4] = S5[0];


endmodule