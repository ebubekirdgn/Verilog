module Compare_1bit(input A,B,output esit , buyuk , kucuk);
		function isBig;
		  input A,B;
		  begin
			  isBig = (A &~B);
		  end
		 
		endfunction
		
		function isSmall;
		  input A,B;
		  begin
			  isSmall = (~A & B);
		  end
		 
		endfunction
		
		function isEqual;
		  input A,B;
		  begin
			  isEqual = (~A & B) | (A & ~B);
		  end
		 
		endfunction
		
		assign esit  = isEqual(A,B);
		assign kucuk = isSmall(A,B);
		assign buyuk = isBig(A,B);
		
endmodule
