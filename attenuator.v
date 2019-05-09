module attenuator(
		  input 	snd_in,
		  input [3:0] 	att, 
		  output [5:0] 	snd_out
		  );
   reg [5:0] 			snd;
 
   always@*
     begin
	if(snd_in==0)snd<=0;
	else
	  begin
	     case(att)
	       0:snd<=63;
	       1:snd<=50;
	       2:snd<=40;
	       3:snd<=32;
	       4:snd<=25;
	       5:snd<=20;
	       6:snd<=16;
	       7:snd<=13;
	       8:snd<=10;
	       9:snd<=8;
	       10:snd<=6;
	       11:snd<=6;
	       12:snd<=4;
	       13:snd<=3;
	       14:snd<=2;
	       15:snd<=0;
	       default:snd<=0;
	     endcase // case (att)
	  end // else: !if(snd_in==0)
     end // always@ *
   assign snd_out=snd;
   
endmodule // attenuator
