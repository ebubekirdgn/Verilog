module compare5bit(input x0,x1,x2,x3,x4,y0,y1,y2,y3,y4 , output e,s,b);
  
   function isEqual;
		input x,y;
		begin
			isEqual = ~(x^y);
		end
   endfunction
	
	function isBig;
		input x,y;
		begin
			isBig = x & ~y;
		end
   endfunction
	
	
	function isSmall;
		input x,y;
		begin
			isSmall = ~x&y;
		end
   endfunction

	assign e = isEqual(x0,y0) & isEqual(x1,y1) & isEqual(x2,y2)&isEqual(x3,y3)&isEqual(x4,y4);
	assign s = (isSmall(x4,y4)) | ( isEqual(x4,y4) & isSmall(x3,y3) ) | ( isEqual(x4,y4) & isEqual(x3,y3) & isSmall(x2,y2) ) |
				  (isEqual(x4,y4) & isEqual(x3,y3) & isEqual(x2,y2) & isSmall(x1,y1) ) | ( isEqual(x4,y4) & isEqual(x3,y3) & isEqual(x2,y2)& isEqual(x1,y1) & isSmall(x0,y0) );
	assign b = ~(e | s);
	
endmodule

module fulladder (input S0, S1, Ci, output S, Co);
	wire N;
	assign N = S0 ^ S1;
	assign S = N ^ Ci;
	assign Co = (S1 & ~N) | (N & Ci);
endmodule

module bcdToDisplay(input i0,i1,i2,i3,output return0,return1,return2,return3,return4,return5,return6);
	mux8x1 A(i1,i2,i3,~i0, 1,i0,1,1,0,0,0,return0);
	mux8x1 B(i1,i2,i3,1,1,~i0,i0,1,0,0,0,return1);
	mux8x1 C(i1,i2,i3,1,i0,1,1,1,0,0,0,return2);
	mux8x1 D(i1,i2,i3,~i0,1,i0,~i0,1,0,0,0,return3);
	mux8x1 E(i1,i2,i3,~i0,~i0,0,~i0,~i0,0,0,0,return4);
	mux8x1 F(i1,i2,i3,~i0,0,1,~i0,1,0,0,0,return5);
	mux8x1 G(i1,i2,i3,0,1,1,~i0,1,0,0,0,return6);
endmodule

module binaryToBcd(input i0,i1,i2,i3,i4,output return0,return1,return2,return3,return4,return5,return6,return7);
	assign return0 = 0;
	assign return1 = 0;
	mux16x1 A(i1,i2,i3,i4,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,return2);
	mux16x1 B(i1,i2,i3,i4,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,1,return3);
	mux16x1 C(i1,i2,i3,i4,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,return4);
	mux16x1 D(i1,i2,i3,i4,0,0,1,1,0,0,0,1,1,0,0,0,1,1,0,0,return5);
	mux16x1 E(i1,i2,i3,i4,0,1,0,1,0,0,1,0,1,0,0,1,0,1,0,0,return6);
	assign return7 = i0;
endmodule

module mux2x1(s0,i0,i1,return);
	input s0,i0,i1;
	output return;
	assign return = (i0&(~s0)) | (i1&s0);
endmodule

module mux4x1(s0,s1,i0,i1,i2,i3,return);
	input s0,s1,i0,i1,i2,i3;
	output return;
	wire r1,r2;
	
	mux2x1 C(s0,i0,i1,r1);
	mux2x1 B(s0,i2,i3,r2);
	mux2x1 A(s1,r1,r2,return);
endmodule 

module mux8x1(s0,s1,s2,i0,i1,i2,i3,i4,i5,i6,i7,return);
	input s0,s1,s2,i0,i1,i2,i3,i4,i5,i6,i7;
	output return;
	wire r1,r2;
	
	
	mux4x1 A(s0,s1,i0,i1,i2,i3,r1);
	mux4x1 B(s0,s1,i4,i5,i6,i7,r2);
	mux2x1 C(s2,r1,r2,return);
endmodule

module mux16x1(s0,s1,s2,s3,i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,return);
	input s0,s1,s2,s3,i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15;
	output return;
	wire r1,r2;
	mux8x1 A(s0,s1,s2,i0,i1,i2,i3,i4,i5,i6,i7,r1);
	mux8x1 B(s0,s1,s2,i8,i9,i10,i11,i12,i13,i14,i15,r2);
	mux2x1 C(s3,r1,r2,return);
endmodule 