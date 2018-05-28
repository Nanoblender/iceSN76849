module tone(input tone_clk,
	    input [9:0] freq,
	    output 	tone_out
	    );
   reg [9:0] 	   freq_cntr;
   reg 		   half_pulse;
   reg 		   out_cntr;
   
   always@(posedge tone_clk)
     begin
	freq_cntr <= freq_cntr + 1;
	if (freq_cntr == freq-1)
	  begin
	     freq_cntr <= 0;
	     half_pulse <= 1;
	  end
	else half_pulse <= 0;
	if(half_pulse == 1)
	  begin 
	     out_cntr <= !out_cntr;
	  end
     end
   
assign tone_out=out_cntr;

endmodule // tone
