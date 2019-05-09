
module noise_freq_sel(
		      input 	  clk, 
		      input 	  tone_clk,
		      input 	  tone,
		      input [2:0] selecta,
		      output 	  noise_clk
		      );
   
   reg 				  noise_clock;
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
   
   always@(posedge clk)
     begin
	if(tone_clk==1)
	  begin
	     clk_cntr <= clk_cntr + 1;
	     if (clk_cntr == div-1)
	       begin
		  clk_cntr <= 0;
		  div_clk<=1;
	       end
	     else div_clk <=0;
	  end
	end
   assign noise_clk=noise_clock;   
endmodule // noise_freq_sel

