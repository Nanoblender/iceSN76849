module baud_gen(
		input  clk,
		output rx_clk
		);
   
   reg [4:0] 	       div_cntr;
   
   
   always@(posedge clk)
     begin
	div_cntr <= div_cntr + 1;
	if (div_cntr == 12)
	  begin
	     div_cntr<=0;
	     rx_clk <= 1;
	  end
	else rx_clk<=0;  
     end
endmodule // baud_gen


module serial_rx(
		 input 	      rx,
		 input 	      rx_clk,
		 output [7:0] data_in,
		 output       new_data_in
		 );

   reg [7:0] 		      Rx_data;
   reg [1:0] 		      in_mem;
   reg 			      start;
   reg [2:0] 		      syncro;		      
   wire 		      sync_clk=(syncro==7);
   reg [3:0] 		      state;

   initial 
     begin
	Rx_data<=0;
	in_mem<=3;
	state<=0;
	start<=1;
	
     end
   
   
   always@(posedge rx_clk)
     begin
	in_mem <= {in_mem[0],rx};
	if(in_mem == 3)start<=1;
	else if(in_mem==0) start<=0;

	if(state==0)syncro<=0;
	else syncro<=syncro+1;

	case(state)
	  4'b0000: if(start==0) state <= 4'b1000;
	  4'b1000: if(sync_clk) state <= 4'b1001;
	  4'b1001: if(sync_clk) state <= 4'b1010;
	  4'b1010: if(sync_clk) state <= 4'b1011;
	  4'b1011: if(sync_clk) state <= 4'b1100;
	  4'b1100: if(sync_clk) state <= 4'b1101;
	  4'b1101: if(sync_clk) state <= 4'b1110;
	  4'b1110: if(sync_clk) state <= 4'b1111;
	  4'b1111: if(sync_clk) state <= 4'b0001;
	  4'b0001: if(sync_clk) state <= 4'b0000;
	  default: state <= 4'b0000;
	endcase // case (state)
	if(sync_clk && state[3]) Rx_data <= {Rx_data[6:0],start}; 
	
     end // always@ (posedge rx_clk)

   
   assign data_in=Rx_data;
   assign new_data_in=(state==0);
   
endmodule // serial_rx

   
