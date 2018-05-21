module iki_bit_carpici(SW,LEDR);

	input[3:0] SW;
	output[3:0]LEDR;
	
	half_adder ha1((SW[1] & SW[2]),(SW[0] & SW[3]),s1,c1);
	half_adder ha2(c1,(SW[1]& SW[3]),s2,c2);
	assign LEDR[0] = SW[0] & SW[2];
	assign LEDR[1] = s1;
	assign LEDR[2] = s2;
	assign LEDR[3] = c2;
	
endmodule

module half_adder(a,b,s,c);
		input a,b;
		output s,c;
		assign s= a^b;
		assign c=a&b;

endmodule
