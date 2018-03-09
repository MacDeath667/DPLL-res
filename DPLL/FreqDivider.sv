module FreqDivider
(
	input wire reset_i,
	input wire clk_i,
	input wire input_i,
	input wire bypass_i,
	input wire [7:0] divFactor_i,
	output wire divided_o
);

	reg divided;
	assign divided_o = bypass_i ? input_i : divided;
	
	reg match;
	reg [7:0] counter;
	assign match = (counter == (divFactor_i - 8'b1));
	
	always_ff @(posedge clk_i or negedge reset_i)
	begin
		
		if (!reset_i)
		begin
		
			divided <= '0;
			counter <= '0;
			
		end
		
		else if (!bypass_i)
		begin
		
			if (match)
			begin
			
				counter <= '0;
				divided <= !divided;
			
			end
			else
				counter <= counter + 8'b1;
		
		end
		
	end

endmodule
