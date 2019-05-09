


module noise(
	     input  clk,
	     input  noise_clk,
	     input  mode,
	     output noise_out,
	     input  rst
	     );
   
   reg [15:0] 	    noise_reg;
   reg 		    modep;

   
   initial noise_reg=1;
   
   
   always@(posedge clk or posedge rst)
     begin
	if(rst)noise_reg<=1;
	else if(noise_clk==1)
	  begin
	     if(mode==1)noise_reg<={noise_reg[14:0],noise_reg[15]^noise_reg[12]};
	     else noise_reg<={noise_reg[14:0],noise_reg[15]};
	  end
     end

   assign noise_out=noise_reg[15];
endmodule // noise





