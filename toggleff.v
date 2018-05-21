module toggleff (SW, KEY, LEDG, HEX0, HEX1);
  input [1:0] SW;
  input [0:0] KEY;
  output [3:0] LEDG;
  output[6:0] HEX0;
  output[6:0] HEX1;
  wire binaryReturn0,binaryReturn1,binaryReturn2,binaryReturn3,binaryReturn4,binaryReturn5,binaryReturn6,binaryReturn7;
  wire displayReturn0,displayReturn1,displayReturn2,displayReturn3,displayReturn4,displayReturn5,displayReturn6,displayReturn7;
  wire display2Return0,display2Return1,display2Return2,display2Return3,display2Return4,display2Return5,display2Return6,display2Return7;

  wire Clk= KEY[0];
  wire Clr= SW[0];
  wire En = SW[1];
  
  wire [3:0] T, Qs;
  
  t_flipflop T0 (En, Clk, Clr, Qs[0]);
  assign T[0] = En & Qs[0];

  t_flipflop T1 (T[0], Clk, Clr, Qs[1]);
  assign T[1] = T[0] & Qs[1];

  t_flipflop T2 (T[1], Clk, Clr, Qs[2]);
  assign T[2] = T[1] & Qs[2];

  t_flipflop T3 (T[2], Clk, Clr, Qs[3]);
  binaryToBcd A(Qs[0],Qs[1],Qs[2],Qs[3],0,return0,return1,return2,return3,return4,return5,return6,return7);
  bcdToDisplay B(return7,return6,return5,return4,displayReturn0,displayReturn1,displayReturn2,displayReturn3,displayReturn4,displayReturn5,displayReturn6);
  bcdToDisplay C(return3,return2,return1,return0,display2Return0,display2Return1,display2Return2,display2Return3,display2Return4,display2Return5,display2Return6);
  assign HEX0[0] = ~displayReturn0;
  assign HEX0[1] = ~displayReturn1;
  assign HEX0[2] = ~displayReturn2;
  assign HEX0[3] = ~displayReturn3;
  assign HEX0[4] = ~displayReturn4;
  assign HEX0[5] = ~displayReturn5;
  assign HEX0[6] = ~displayReturn6;
  
  assign HEX1[0] = ~display2Return0;
  assign HEX1[1] = ~display2Return1;
  assign HEX1[2] = ~display2Return2;
  assign HEX1[3] = ~display2Return3;
  assign HEX1[4] = ~display2Return4;
  assign HEX1[5] = ~display2Return5;
  assign HEX1[6] = ~display2Return6;
endmodule


module t_flipflop (En, Clk, Clr, Q);
  input En, Clk, Clr;
  output reg Q;

  always @ (posedge Clk)
    if (Clr)
      Q = 0;
    else if (En)
      Q = ~Q;
endmodule
module bcdToDisplay(i0,i1,i2,i3,return0,return1,return2,return3,return4,return5,return6);
	input i0,i1,i2,i3;
	output return0,return1,return2,return3,return4,return5,return6;
	sekiz_bir_mux A(i1,i2,i3,~i0,1,i0,1,1,0,0,0,return0);
	sekiz_bir_mux B(i1,i2,i3,1,1,~i0,i0,1,0,0,0,return1);
	sekiz_bir_mux C(i1,i2,i3,1,i0,1,1,1,0,0,0,return2);
	sekiz_bir_mux D(i1,i2,i3,~i0,1,i0,~i0,1,0,0,0,return3);
	sekiz_bir_mux E(i1,i2,i3,~i0,~i0,0,~i0,~i0,0,0,0,return4);
	sekiz_bir_mux F(i1,i2,i3,~i0,0,1,~i0,1,0,0,0,return5);
	sekiz_bir_mux G(i1,i2,i3,0,1,1,~i0,1,0,0,0,return6);
endmodule

module binaryToBcd(i0,i1,i2,i3,i4,return0,return1,return2,return3,return4,return5,return6,return7);
	input i0,i1,i2,i3,i4;
	output return0,return1,return2,return3,return4,return5,return6,return7;
	assign return0 = 0;
	assign return1 = 0;
	onalti_bir_mux A(i1,i2,i3,i4,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,return2);
	onalti_bir_mux B(i1,i2,i3,i4,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,1,return3);
	onalti_bir_mux C(i1,i2,i3,i4,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,return4);
	onalti_bir_mux D(i1,i2,i3,i4,0,0,1,1,0,0,0,1,1,0,0,0,1,1,0,0,return5);
	onalti_bir_mux E(i1,i2,i3,i4,0,1,0,1,0,0,1,0,1,0,0,1,0,1,0,0,return6);
	assign return7 = i0;
endmodule
module iki_bir_mux(s0,i0,i1,return);
	input s0,i0,i1;
	output return;
	assign return = (i0&(~s0)) | (i1&s0);
endmodule

module dort_bir_mux(s0,s1,i0,i1,i2,i3,return);
	input s0,s1,i0,i1,i2,i3;
	output return;
	wire r1,r2;
	
	iki_bir_mux C(s0,i0,i1,r1);
	iki_bir_mux B(s0,i2,i3,r2);
	iki_bir_mux A(s1,r1,r2,return);
endmodule 

module sekiz_bir_mux(s0,s1,s2,i0,i1,i2,i3,i4,i5,i6,i7,return);
	input s0,s1,s2,i0,i1,i2,i3,i4,i5,i6,i7;
	output return;
	wire r1,r2;
	
	
	dort_bir_mux A(s0,s1,i0,i1,i2,i3,r1);
	dort_bir_mux B(s0,s1,i4,i5,i6,i7,r2);
	iki_bir_mux C(s2,r1,r2,return);
endmodule

module onalti_bir_mux(s0,s1,s2,s3,i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,return);
	input s0,s1,s2,s3,i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15;
	output return;
	wire r1,r2;
	
	
	sekiz_bir_mux A(s0,s1,s2,i0,i1,i2,i3,i4,i5,i6,i7,r1);
	sekiz_bir_mux B(s0,s1,s2,i8,i9,i10,i11,i12,i13,i14,i15,r2);
	iki_bir_mux C(s3,r1,r2,return);
endmodule 