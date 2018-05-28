module reception(
		 input 	      clk,
		 input [7:0]  data_in,
		 input 	      new_data_in,
		 output [2:0] adress,
		 output [9:0] value,
		 output       load,
		 output       noise_rst
		 );


   reg [7:0] 		      prev_data;
   reg [9:0] 		      val;
   
   
always@(posedge clk)
  begin
     noise_rst<=0;
     load<=0;
     if(new_data_in==1)
       begin
	  if(data_in[7]==1)
	    begin
	       case(data_in[6:4])
		 3'b000,3'b010,3'b100:
		   begin
		      prev_data<=data_in;  
		      adress<=data_in[6:4];
		   end
		 3'b001,3'b011,3'b111,3'b101:
		   begin
		      load<=1;
		      adress<={data_in[6:4]};
		      val<={{6{0}},data_in[3:0]};
		      //value<={data_in[4:7],{6{0}}};
		   end
		 3'b110:
		   begin
		      noise_rst<=1;
		      load<=1;
		      adress<=data_in[6:4];
		      val<={{7{0}},data_in[2:0]};
		   end
	       endcase // case (data_in[3:1])
	    end // if (data_in[0]==1)
	  else if(prev_data[7]==1 && (prev_data[6:4]==0 ||prev_data[6:4]==2 || prev_data[6:4]==4))
	    begin
	       val<={data_in[5:0],prev_data[3:0]};
	       prev_data<=data_in;
	       load<=1;
	    end
       end // if (load==1)
  end // always@ *
   
   assign value=val;
   

endmodule // reception
