module sigma_delta(
		   input       clk,
		   input [7:0] in,
		   output      out
		   );

   reg [8:0] 		       accu;
   
   always@(posedge clk)
     begin
	accu<=accu[7:0]+in;
     end
   
   assign out=accu[8]; 
endmodule // sigma_delta

   
