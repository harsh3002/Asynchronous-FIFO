
`timescale 1ns/1ns

module fifo_mem #(parameter DATA_WIDTH = 8,
		  parameter ADDR_SIZE  = 4)
(output reg [DATA_WIDTH-1:0] rd_data,
 input                   rd_ena,
 input 			 wrt_clk,
 input  [DATA_WIDTH-1:0] wrt_data,
 input  [ADDR_SIZE-1:0]  wrt_addr,rd_addr,
 input  		 wrt_ena,wrt_full);
 
 localparam DEPTH = (ADDR_SIZE<<1);
 reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
 
 always@(posedge wrt_clk) begin
	if(wrt_ena & !wrt_full) 
		mem[wrt_addr] <= wrt_data;
 end

assign rd_data = rd_ena?mem[rd_addr]:0;

endmodule
