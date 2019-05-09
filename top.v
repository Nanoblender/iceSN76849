module top(
	   input  clk,
	   input  ext_clk,
	   input  rx,
//	   output tx,

	   input  pD0,
	   input  pD1,
	   input  pD2,
	   input  pD3,
	   input  pD4,
	   input  pD5,
	   input  pD6,
	   input  pD7,
	   input  WEb,
	   output READY,

	   output dac_out,
	   
	   output LED1,
	   output LED2,
	   output LED3,
	   output LED4,
	   output LED5,
	   output LED6,
	   output LED7,
	   output LED8
	   );
   
   
   reg [2:0] 	  div_cntr1;
   reg [4:0] 	  dac_cntr;
   reg [3:0] 	  sn_cntr; 	  
   reg 		  int_clk;
   reg 		  dac_clk;
   wire 	  snd_clk;
 
   wire [9:0] 	  f1;
   wire [3:0] 	  a1;
   wire [9:0] 	  f2;
   wire [3:0] 	  a2;
   wire [9:0] 	  f3;
   wire [3:0] 	  a3;
   wire [2:0] 	  f4;
   wire [3:0] 	  a4;
   wire [2:0]	  adress;
   wire [9:0]	  value;
   wire 	  load;
   wire 	  sndw1;
   wire 	  sndw2;
   wire 	  sndw3;
   wire 	  noise_clk;
   wire 	  noisew;
   wire [5:0] 	  ch1_att;
   wire [5:0] 	  ch2_att;
   wire [5:0] 	  ch3_att;
   wire [5:0] 	  ch4_att;
   wire [7:0] 	  mixed_snd;
   wire 	  rx_clk;
   wire [7:0] 	  data_in;
   wire 	  new_data_in;
   wire 	  noise_rst;
   
   
   always@(posedge clk)
     begin
	div_cntr1 <= div_cntr1 + 1;
	dac_cntr <= dac_cntr+1;
	if (div_cntr1 == 6-1)
	  begin
	     div_cntr1<=0;
	     int_clk <= 1;
	  end
	else int_clk<=0;
     end // always@ (posedge clk)
   
   
   always@(posedge ext_clk)sn_cntr <= sn_cntr + 1;
   assign snd_clk=sn_cntr==4'b1111;
   



 
 /*
   baud_gen baud_gen(
		     .clk(clk),
		     .rx_clk(rx_clk)
		  );
  
   serial_rx serial_rx(
		    .rx(rx),
		    .rx_clk(rx_clk),
		    .data_in(data_in),
		    .new_data_in(new_data_in)
		    );
   */

   
   reception reception(
		       .clk(clk),
		       .data_in(data_in),
		       .new_data_in(new_data_in),
		       .adress(adress),
		       .value(value),
		       .load(load),
		       .noise_rst(noise_rst)
		       );
   

   tone tone_gen1(
		  .clk(clk),
		  .tone_clk (snd_clk),
		  .freq (f1),
		  .tone_out(sndw1) 
		  );
   tone tone_gen2(
		  .clk(clk),
		  .tone_clk (snd_clk),
		  .freq (f2),
		  .tone_out(sndw2) 
		  );
   tone tone_gen3(
		  .clk(clk),
		  .tone_clk (snd_clk),
		  .freq (f3),
		  .tone_out(sndw3) 
		  );
   noise_freq_sel noise_sel(
			    .clk(clk),
			    .tone_clk(snd_clk),
			    .tone(sndw3),
			    .selecta(f4[2:0]),
			    .noise_clk(noise_clk)
			    );
   noise noise_gen(
		   .clk(clk),
		   .noise_clk(noise_clk),
		   .mode(f4[2]),
		   .noise_out(noisew),
		   .rst(noise_rst)
		   );

   control_reg ctrl_reg(
			.clk (clk),
			.adress (adress),
			.value (value),
			.load (load),
			.freq1 (f1),
			.att1 (a1),
			.freq2 (f2),
			.att2(a2),
			.freq3 (f3),
			.att3 (a3),
			.freq4 (f4),
			.att4 (a4),
			);
   attenuator attenuator1(
			  .snd_in(sndw1),
			  .att(a1),
			  .snd_out(ch1_att)
			  );
   attenuator attenuator2(
			  .snd_in(sndw2),
			  .att(a2),
			  .snd_out(ch2_att)
			  );
   attenuator attenuator3(
			  .snd_in(sndw3),
			  .att(a3),
			  .snd_out(ch3_att)
			  );
   attenuator attenuator4(
			  .snd_in(noisew),
			  .att(a4),
			  .snd_out(ch4_att)
			  ); 
   
   chan_mixer mixer(
		    .ch1(ch1_att),
		    .ch2(ch2_att),
		    .ch3(ch3_att),
		    .ch4(ch4_att),
		    .mix_out(mixed_snd)
		    );

  sigma_delta sigma_delta(
			  .clk(clk),
			  .in(mixed_snd),
			  .out(dac_out)
			  );
 
   
   
      
   assign LED1=(a1<10);
   assign LED2=(a2<10);
   assign LED3=(a3<10);
   assign LED4=(a4<0);
   assign LED5=0;
   assign LED6=0;
   assign LED7=READY;
   assign LED8=new_data_in;
    
   assign new_data_in=~WEb;
   assign data_in={pD7,pD6,pD5,pD4,pD3,pD2,pD1,pD0};
   assign READY=~load;
   
   
endmodule // top
