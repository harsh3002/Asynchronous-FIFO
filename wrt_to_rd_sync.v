
`timescale 1ns/1ns

module wrt_to_rd_sync 
	#(parameter ADDR_SIZE = 4)
	 (output reg [ADDR_SIZE:0] sync_wrt_ptr,
	  input      [ADDR_SIZE:0] wrt_ptr,
	  input 		   rd_clk, rd_rst);

		reg [ADDR_SIZE:0] wrt_temp_ptr;
		
		always@(posedge rd_clk , posedge rd_rst) begin
			if(rd_rst) 
				{sync_wrt_ptr,wrt_temp_ptr} <= 0;
			else
				{sync_wrt_ptr,wrt_temp_ptr} <= {wrt_temp_ptr,wrt_ptr};		
		end
	  
 endmodule
