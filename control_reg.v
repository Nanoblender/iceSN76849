module control_reg(
		   input 	clk,
		   input [2:0] 	adress,
		   input [9:0] 	value,
		   input 	load,
		   output [9:0] freq1 ,
		   output [3:0] att1,
		   output [9:0] freq2,
		   output [3:0] att2 ,
		   output [9:0] freq3,
		   output [3:0] att3 ,
		   output [2:0] freq4,
		   output [3:0] att4
		   );
   reg [9:0] 		  f1;
   reg [3:0] 		  a1;
   reg [9:0]  		  f2;
   reg [3:0] 		  a2;
   reg [9:0] 		  f3;
   reg [3:0] 		  a3;
   reg [2:0] 		  f4;
   reg [3:0] 		  a4;

   always@(posedge clk)
     begin;
	if (load==1)
	  begin
	     case(adress)
	       0:f1<=value;
	       1:a1<=value[3:0];
	       2:f2<=value;
	       3:a2<=value[3:0];
	       4:f3<=value;
	       5:a3<=value[3:0];
	       6:f4<=value[2:0];
	       7:a4<=value[3:0];
	     endcase // case (adress)
	  end // if (load==1)
     end // always@ (posedge clk)
   

   assign freq1=f1;
   assign att1 =a1;
   assign freq2=f2;
   assign att2 =a2;
   assign freq3=f3;
   assign att3 =a3;
   assign freq4=f4;
   assign att4 =a4;
   
   
endmodule // control_reg
