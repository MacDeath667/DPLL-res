module top
(
	input wire reset_i,
	input wire clk_i,
	input wire  signal_i,
	output wire signal_o
);

	DPLL dpll(.*);
	
endmodule
