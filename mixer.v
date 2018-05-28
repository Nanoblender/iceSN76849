module attenuator(
		  input 	snd_in,
		  input [3:0] 	att, 
		  output [5:0] 	snd_out
		  );
   always@*
     begin
	if(snd_in==0)snd_out<=0;
	else
	  begin
	     case(att)
	       0:snd_out<=63;
	       1:snd_out<=50;
	       2:snd_out<=40;
	       3:snd_out<=32;
	       4:snd_out<=25;
	       5:snd_out<=20;
	       6:snd_out<=16;
	       7:snd_out<=13;
	       8:snd_out<=10;
	       9:snd_out<=8;
	       10:snd_out<=6;
	       11:snd_out<=6;
	       12:snd_out<=4;
	       13:snd_out<=3;
	       14:snd_out<=2;
	       15:snd_out<=0;
	     endcase // case (att)
	  end // else: !if(snd_in==0)
     end // always@ *
endmodule // attenuator

module chan_mixer(
		  input [5:0] 	ch1,
		  input [5:0] 	ch2,
		  input [5:0] 	ch3,
		  input [5:0] 	ch4,
		  output [7:0] mix_out
		  );
   always@*
     begin
	mix_out<=ch1+ch2+ch3+ch4;	
     end
endmodule // chan_mixer
