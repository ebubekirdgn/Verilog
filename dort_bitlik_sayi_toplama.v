module dort_bitlik_sayi_toplama(Giris,Cikis);

   input [7:0]Giris;
	output [4:0]Cikis;
	 fulladder fa1 (Giris[0],Giris[4],0,s1,c1);
	 fulladder fa2 (Giris[1],Giris[5],c1,s2,c2);
	 fulladder fa3 (Giris[2],Giris[6],c2,s3,c3);
	 fulladder fa4 (Giris[3],Giris[7],c3,s4,c4);

	 assign Cikis[0]= s1;
	  assign Cikis[1]= s1;
	   assign Cikis[2]= s1;
		 assign Cikis[3]= s1;
		  assign Cikis[4]= s1;
	 
endmodule

module fulladder (input a,b,ci, output s,co);
 
  wire d;
   assign d = a^b;
	assign s=d^ci;
	assign co = (b & ~d) | (d & ci);


endmodule