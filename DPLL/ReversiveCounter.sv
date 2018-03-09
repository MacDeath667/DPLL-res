module ReversiveCounter
(
	input wire reset_i,
	input wire clk_i,
	input wire increment_i,
	input wire decrement_i,
	input wire loadNewValue_i,
	input wire [7:0] loadingValue_i,
	output wire [7:0] value_o
);

	reg [7:0] value;
	
	assign value_o = value;
	
	always_ff @(posedge clk_i or negedge reset_i)
	begin
	
		if (!reset_i)
			value <= '0;
		else if (clk_i)
		begin
		
			if (loadNewValue_i)
				value <= loadingValue_i;
			else if (increment_i && !decrement_i)
				value <= value + 8'b1;
			else if (!increment_i && decrement_i)
				value <= value + 8'hff; // ff = -1 для 8 бит
		end
		
	end

endmodule
