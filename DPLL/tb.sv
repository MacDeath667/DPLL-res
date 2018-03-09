module tb;

	reg reset_i;
	reg clk_i;
	reg signal_i;
	wire signal_o;
	
	initial
	begin
		reset_i = '0;
		clk_i = '0;
		signal_i = '0;
		
		#43ns;
		reset_i = '1;
	end
	
	initial
	begin
		#50ms;
		$stop;
	end
		
	
	top top_implementation(.*);
	
	always
	begin
		#50ns;
		clk_i <= !clk_i;
	end	
	
	always
	begin
		#5us;
		signal_i <= !signal_i;
	end	

endmodule
