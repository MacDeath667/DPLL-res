module PhaseController
(
	input wire reset_i,
	input wire clk_i,
	input wire positiveShift_i,
	input wire negativeShift_i,
	output reg phasedSignal_o
);

	wire [6:0] counter;
	reg [6:0] loadingValue;
	reg counterOverflowFlag;
	
	ReversiveCounter resetCounter
	(
		.reset_i(reset_i),
		.clk_i(clk_i),
		.increment_i('1),
		.decrement_i('0),
		.loadNewValue_i(counterOverflowFlag),
		.loadingValue_i(loadingValue),
		.value_o(counter)
	);
	
	assign counterOverflowFlag = (counter == 8'h3F);
	
	always_ff @(posedge clk_i or negedge reset_i)
	begin
		
		if (!reset_i)
		begin
			
			phasedSignal_o <= '0;
			loadingValue <= '0;
		end
		
		else if (clk_i)
		begin
			
			if (counterOverflowFlag)
				phasedSignal_o <= !phasedSignal_o;
			
			if (positiveShift_i)
				loadingValue <= loadingValue + 8'hFF;
			else if (negativeShift_i)
				loadingValue <= loadingValue + 8'h1;
				
		end
		
	end

endmodule
