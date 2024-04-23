

`timescale 1ns/1ns

module read_pointer_generation
	#(parameter ADDR_SIZE = 4)
	(output reg 		    rd_empty,
	 output     [ADDR_SIZE-1:0] rd_addr,
	 output reg [ADDR_SIZE:0]   rd_ptr,
	 input 	    [ADDR_SIZE:0]   sync_wrt_ptr,
	 input 			    rd_ena, rd_clk, rd_rst);
	 
		reg  [ADDR_SIZE:0] rd_bin;
		wire [ADDR_SIZE:0] rd_bin_nxt,rd_gray_nxt;
		wire 		   rd_empty_val;
		
		always@(posedge rd_clk , posedge rd_rst) begin
			if(rd_rst) 
				{rd_bin,rd_ptr} <= 0;
			else
				{rd_bin,rd_ptr} <= {rd_bin_nxt,rd_gray_nxt};				
		end 
	 
		always@(posedge rd_clk , posedge rd_rst) begin
			if(rd_rst)
				rd_empty <= 1'b1;
			else
				rd_empty <=  rd_empty_val;
		end
		
		assign rd_bin_nxt   =  rd_bin + (!rd_empty & rd_ena);
		assign rd_gray_nxt  = (rd_bin_nxt>>1) ^ rd_bin_nxt;
		assign rd_empty_val = (sync_wrt_ptr == rd_gray_nxt);
		assign rd_addr	    =  rd_bin[ADDR_SIZE-1:0];
 endmodule
