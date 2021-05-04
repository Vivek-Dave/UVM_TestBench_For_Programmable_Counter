module pcnt(
			output logic [15:0] dout,
			input [15:0]        din,
			input               ld,inc,clk,rst_n
			);
			
		always_ff@(posedge clk or negedge rst_n)
			if(!rst_n)   dout<='0;
			else if(ld)  dout<=din;
			else if(inc) dout<=dout+1;
			
endmodule