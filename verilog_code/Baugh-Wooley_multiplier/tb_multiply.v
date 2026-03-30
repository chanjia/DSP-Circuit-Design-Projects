module tb_multiply;

    reg [5:0] A;
	reg [7:0] B;
    wire [13:0] P;
    wire cout;  
    integer i, j, error;

    multiply mp (.A(A), .B(B), .P(P));
	
	initial
	begin
        A = 1;
        B = 1;
        error = 0;
		for(i=1; i<64; i=i+21)
		begin
            for(j=1; j<256; j=j+51)
			begin
                A = i;
                B = j;
				
                #10;
                 
            end  
      end
    end 
    
endmodule