


`timescale 1ns/1ns

module fifo_top_module
	#(parameter ADDR_SIZE  = 4,
	  parameter DATA_WIDTH = 8)
	 ( output   [DATA_WIDTH-1:0] rd_data,
	   output  			rd_empty,
	   output			wrt_full,
	   input       [DATA_WIDTH-1:0] wrt_data,
	   input	   		rd_clk, rd_rst, rd_ena,
	   input 			wrt_clk, wrt_rst, wrt_ena);
	   
		wire [ADDR_SIZE:0] wrt_ptr, rd_ptr, rd_sync_ptr, wrt_sync_ptr;
		wire [ADDR_SIZE-1:0] wrt_addr,rd_addr;
	   
	   fifo_mem  mem_inst (
	   .rd_ena(rd_ena),
	   .rd_data(rd_data),
	   .wrt_data(wrt_data),
	   .wrt_clk(wrt_clk),
	   .wrt_ena(wrt_ena),
	   .rd_addr(rd_addr),
	   .wrt_addr(wrt_addr),
	   .wrt_full(wrt_full));
	   
	   
	   write_pointer_gen  wrt_ptr_gen_inst(
	   .wrt_addr(wrt_addr),
	   .wrt_ptr(wrt_ptr),
	   .wrt_full(wrt_full),
	   .sync_rd_ptr(rd_sync_ptr),
	   .wrt_clk(wrt_clk),
	   .wrt_inc(wrt_ena),
	   .wrt_rst(wrt_rst));
	   
	   read_pointer_generation rd_ptr_gen_inst(
	   .rd_empty(rd_empty),
	   .rd_ptr(rd_ptr),
	   .rd_addr(rd_addr),
	   .sync_wrt_ptr(wrt_sync_ptr),
	   .rd_clk(rd_clk),
	   .rd_ena(rd_ena),
	   .rd_rst(rd_rst));
	   
	   rd_to_wrt_sync rd_wrt_sync_inst(
	   .sync_rd_ptr(rd_sync_ptr),
	   .rd_ptr(rd_ptr),
	   .wrt_clk(wrt_clk),
	   .wrt_rst(wrt_rst));
	   
	   wrt_to_rd_sync  wrt_rd_sync_inst(
	   .sync_wrt_ptr(wrt_sync_ptr),
	   .wrt_ptr(wrt_ptr),
	   .rd_clk(rd_clk),
	   .rd_rst(rd_rst));
	   
endmodule
