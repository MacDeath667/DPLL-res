module DPLL
(
	input wire reset_i,
	input wire clk_i,
	input wire  signal_i,
	output wire signal_o
);
	
	wire signalB;
	wire forwarding;
	wire slowing;
	wire negativeShift;
	wire positiveShift;
	wire phasedSignal;
	
	assign signal_o = signalB;
	
	PhaseDetector detector
	(
		.reset_i(reset_i),
		.clk_i(clk_i), // соединение внешнего сигнала clk_i и внутреннего сигнала clk_i
							// модуля PhaseDetector (обозначен как .clk_i)
		.signalA_i(signal_i),
		.signalB_i(signalB),
		.forwarding_o(forwarding),
		.slowing_o(slowing)
	);
	
	SerialLoopFilter filter
	(
		.reset_i(reset_i),
		.clk_i(clk_i),
		.forwarding_i(forwarding),
		.slowing_i(slowing),
		.negativeShift_o(negativeShift),
		.positiveShift_o(positiveShift)
	);
	
	PhaseController phaseController
	(
		.reset_i(reset_i),
		.clk_i(clk_i),
		.negativeShift_i(negativeShift),
		.positiveShift_i(positiveShift),
		.phasedSignal_o(phasedSignal)
	);
		
	FreqDivider divider
	(
		.reset_i(reset_i),
		.clk_i(clk_i),
		.input_i(phasedSignal),
		.bypass_i(1'b1),
		.divFactor_i(7'd10),
		.divided_o(signalB)
	);
	
endmodule
