module PhaseDetector
(
	input wire reset_i,
	input wire clk_i,
	input wire signalA_i,
	input wire signalB_i,
	output reg forwarding_o,
	output reg slowing_o
);
	
	wire isInputDifferent = signalA_i ^ signalB_i;

	always_ff @(posedge clk_i or negedge reset_i)
	begin
	
		if (reset_i == 1'b0) // same as if (~reset_i) -- bitwise negation
									// or if (!reset_i) -- logical negation
		begin
			forwarding_o <= 1'b0;
			slowing_o <= 1'b0;
		end
		
		else if (clk_i == 1'b1)
		begin
			// normal work
			forwarding_o <= isInputDifferent & signalB_i;
			slowing_o <= isInputDifferent & signalA_i;
		end
		
	end
endmodule
