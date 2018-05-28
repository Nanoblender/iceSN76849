


module noise(
	     input  noise_clk,
	     input  mode,
	     output noise_out,
	     output rst
	     );
   
   reg [15:0] 	    noise_reg;
   reg 		    modep;
   wire 	    nextbit;
   
   initial noise_reg=1;
   
   
   always@(posedge noise_clk or posedge rst)
     begin
	if(rst)noise_reg<=1;
	else
	  begin
	     if(mode==1)nextbit<=noise_reg[15]^noise_reg[12];
	     else nextbit<=noise_reg[15];
	     noise_reg<={noise_reg[14:0],nextbit};
	  end
     end

   assign noise_out=noise_reg[15];
endmodule // noise






module noise_freq_sel(
		      input 	  tone_clk,
		      input 	  tone,
		      input [2:0] selecta,
		      output 	  noise_clk
		      );
   wire 			  noise_clock;
   reg 				  div_clk;
   reg [7:0] 			  div;
   reg [7:0] 			  clk_cntr;
   reg [2:0] 			  selectap;
   

  
   
   always@*
     begin
	noise_clock=div_clk;
	div=32;
	
	case(selecta)
	  0:div=32;
	  1:div=64;
	  2:div=128;
	  3:noise_clock=tone;
	endcase // case (selecta)
     end // always@ *
   
   always@(posedge tone_clk)
     begin
	clk_cntr <= clk_cntr + 1;
	if (clk_cntr == div-1)
	  begin
	     clk_cntr <= 0;
	     div_clk<=1;
	  end
	else div_clk <=0;
     end
   
   assign noise_clk=noise_clock;   
endmodule // noise_freq_sel

