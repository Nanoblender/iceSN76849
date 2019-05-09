
module chan_mixer(
		  input [5:0] 	ch1,
		  input [5:0] 	ch2,
		  input [5:0] 	ch3,
		  input [5:0] 	ch4,
		  output [7:0] mix_out
		  );
   reg [7:0] 		       mix;
   always@*
     begin
	mix<=ch1+ch2+ch3+ch4;	
     end
   assign mix_out=mix;
   
endmodule // chan_mixer
