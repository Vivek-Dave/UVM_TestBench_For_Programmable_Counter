`include "CYCLE.sv"

interface dut_if(input clk);

	logic [15:0] dout;
	logic [15:0] din;
	logic        ld,inc,rst_n;
	
	clocking cb@(posedge clk);
		default input #1step output `Tdrive;
		input  dout;
		output din;
		output ld,inc,rst_n;
	endclocking

endinterface

