module Project2 (input [3:0]KEY,input[17:0] SW,output[3:0] LEDR,output [3:0]LEDG,output[6:0] HEX0,HEX1,HEX4,HEX5,HEX6,HEX7);
//SW[16],SW[17] => Ürün Seçme
 
	 
	 
	// Selin baslangıc
	reg[4:0] r0, r1, r2, r3;
	
	initial begin
		r0 = 5'b00001;
		r1 = 5'b00011;
		r2 = 5'b00101;
		r3 = 5'b01010;		
	end
	
	// KIRMIZI LED YAK
	assign LEDR[0] = ~SW[17] & ~SW[16];
	assign LEDR[1] = ~SW[17] &  SW[16];
	assign LEDR[2] =  SW[17] & ~SW[16];
   assign LEDR[3] =  SW[17] &  SW[16];
	
	wire [4:0] u0,u1,u2,u3;
	assign u0=r0;
	assign u1=r1;
	assign u2=r2;
	assign u3=r3;
 
   mux4x1 m4_0 (SW[16],SW[17],u0[0],u1[0],u2[0],u3[0],urun_fiyati0);
	mux4x1 m4_1 (SW[16],SW[17],u0[1],u1[1],u2[1],u3[1],urun_fiyati1);
	mux4x1 m4_2 (SW[16],SW[17],u0[2],u1[2],u2[2],u3[2],urun_fiyati2);
	mux4x1 m4_3 (SW[16],SW[17],u0[3],u1[3],u2[3],u3[3],urun_fiyati3);
	mux4x1 m4_4 (SW[16],SW[17],u0[4],u1[4],u2[4],u3[4],urun_fiyati4);
	 // Selin bitis
	
	
	
	//Ebubekir Baslangic
	compare5bit cp5_0(SW[0],SW[1],SW[2],SW[3],SW[4], urun_fiyati0,urun_fiyati1,urun_fiyati2,urun_fiyati3,urun_fiyati4,Equal,Small,Big);
	assign En = ~Small;	//Enable => Küçük Değilse=1
  //Ebubekir bitis
    

	  
	//PARA ÜSTÜ HESAPLAMA Merve Baslangic
	fulladder f0 (SW[0],urun_fiyati0^1,1 ,para_ustu0,c0);
	fulladder f1 (SW[1],urun_fiyati1^1,c0,para_ustu1,c1);
	fulladder f2 (SW[2],urun_fiyati2^1,c1,para_ustu2,c2);
	fulladder f3 (SW[3],urun_fiyati3^1,c2,para_ustu3,c3);
	fulladder f4 (SW[4],urun_fiyati4^1,c3,para_ustu4,c4);
	//Merve Bitis
	
	 
	// PARA GİRiŞİ YAZDIRMA Furkan Baslangic
	wire para=SW[0]|SW[1]|SW[2]|SW[3]|SW[4]; //para girişi sıfırsa para degeri sıfır olur ve ledleri yakmaz.
	binaryToBcd P_Giris(SW[0],SW[1],SW[2],SW[3],SW[4],return00,return01,return02,return03,return04,return05,return06,return07);
	bcdToDisplay P_Giris_Birler(return07,return06,return05,return04,pg_b0,pg_b1,pg_b2,pg_b3,pg_b4,pg_b5,pg_b6);	//Birler basamağı
   bcdToDisplay P_Giris_Onlar(return03,return02,return01,return00,pg_o0,pg_o1,pg_o2,pg_o3,pg_o4,pg_o5,pg_o6);	// Onlar basamağı
	
	assign HEX4[0] = ~pg_b0 | ~para; //hexler 1 de yanar sıfırda yanmaz. 
	assign HEX4[1] = ~pg_b1 | ~para;
	assign HEX4[2] = ~pg_b2 | ~para;
	assign HEX4[3] = ~pg_b3 | ~para;
	assign HEX4[4] = ~pg_b4 | ~para;
	assign HEX4[5] = ~pg_b5 | ~para;
	assign HEX4[6] = ~pg_b6 | ~para;
  
	assign HEX5[0] = ~pg_o0| ~para;
	assign HEX5[1] = ~pg_o1| ~para;
	assign HEX5[2] = ~pg_o2| ~para;
	assign HEX5[3] = ~pg_o3| ~para;
	assign HEX5[4] = ~pg_o4| ~para;
	assign HEX5[5] = ~pg_o5| ~para;
	assign HEX5[6] = ~pg_o6| ~para;
	//Furkan Bitis
	
	
	
	/*ORTAK YAPILACAK*/
	// ÜRÜN FİYATI YAZDIRMA
	binaryToBcd  U_Fiyat(urun_fiyati0,urun_fiyati1,urun_fiyati2,urun_fiyati3,urun_fiyati4,return10,return11,return12,return13,return14,return15,return16,return17);
	bcdToDisplay U_Fiyat_Birler(return17,return16,return15,return14,uf_b0,uf_b1,uf_b2,uf_b3,uf_b4,uf_b5,uf_b6);
   bcdToDisplay U_Fiyat_Onlar(return13,return12,return11,return10,uf_o0,uf_o1,uf_o2,uf_o3,uf_o4,uf_o5,uf_o6);
	
	
	assign HEX6[0] = ~uf_b0;
	assign HEX6[1] = ~uf_b1;
	assign HEX6[2] = ~uf_b2;
	assign HEX6[3] = ~uf_b3;
	assign HEX6[4] = ~uf_b4;
	assign HEX6[5] = ~uf_b5;
	assign HEX6[6] = ~uf_b6;
  
	assign HEX7[0] = ~uf_o0;
	assign HEX7[1] = ~uf_o1;
	assign HEX7[2] = ~uf_o2;
	assign HEX7[3] = ~uf_o3;
	assign HEX7[4] = ~uf_o4;
	assign HEX7[5] = ~uf_o5;
	assign HEX7[6] = ~uf_o6;

	
	// PARA ÜSTÜ YAZDIRMA
	binaryToBcd  P_Ustu(para_ustu0,para_ustu1,para_ustu2,para_ustu3,para_ustu4,return20,return21,return22,return23,return24,return25,return26,return27);
	bcdToDisplay P_Ustu_Birler(return27,return26,return25,return24,pu_b0,pu_b1,pu_b2,pu_b3,pu_b4,pu_b5,pu_b6);
   bcdToDisplay P_Ustu_Onlar(return23,return22,return21,return20,pu_o0,pu_o1,pu_o2,pu_o3,pu_o4,pu_o5,pu_o6);
	
	reg p1,p2, p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14;
	
	assign HEX0[0]=~p1 | reset;
	assign HEX0[1]=~p2 | reset;
	assign HEX0[2]=~p3 | reset;
	assign HEX0[3]=~p4 | reset;
	assign HEX0[4]=~p5 | reset;
	assign HEX0[5]=~p6 | reset;
	assign HEX0[6]=~p7 | reset;

	assign HEX1[0]=~p8  | reset;
	assign HEX1[1]=~p9  | reset;
	assign HEX1[2]=~p10 | reset;
	assign HEX1[3]=~p11 | reset;
	assign HEX1[4]=~p12 | reset;
	assign HEX1[5]=~p13 | reset;
	assign HEX1[6]=~p14 | reset;
		
	/*ORTAK YAPILACAK*/
	
	wire reset;
	reg reset1,reset2;
	
	assign reset = ~(reset1 ^ reset2);
	 
	
	reg a,b,c,d;
	assign LEDG[0] = a & ~reset;
	assign LEDG[1] = b & ~reset;
	assign LEDG[2] = c & ~reset;
   assign LEDG[3] = d & ~reset;
	
	
	 
	 //Ebubekir Baslangic
	always @(posedge ~KEY[0])
		begin
		
		  reset1 <= ~reset2;
		  
		  a <=  ~SW[17] & ~SW[16]	& En;
		  b <=  ~SW[17] &  SW[16]	& En;
		  c <=   SW[17] & ~SW[16]	& En;
		  d <=   SW[17] &  SW[16]	& En;
		
		  p1 <= pu_b0 & En;
		  p2 <= pu_b1 & En;
		  p3 <= pu_b2 & En;
		  p4 <= pu_b3 & En;
		  p5 <= pu_b4 & En;
		  p6 <= pu_b5 & En;
		  p7 <= pu_b6 & En;
		  
		  p8 <= pu_o0 & En;
		  p9 <= pu_o1 & En;
		  p10 <= pu_o2 & En;
		  p11 <= pu_o3 & En;
		  p12 <=  pu_o4 & En;
		  p13 <=  pu_o5 & En;
		  p14 <=  pu_o6 & En;
		 
		end
	 	 //Ebubekir Bitis

	 // Furkan Baslangic
	 always @(posedge ~KEY[1])
	 begin 
	  reset2 <= reset1;
	 end
	 
endmodule
