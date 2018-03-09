transcript on
vlib work

vlog -sv ./ReversiveCounter.sv
vlog -sv ./KGB.sv
vlog -sv ./SerialLoopFilter.sv
vlog -sv ./PhaseDetector.sv
vlog -sv ./PhaseController.sv
vlog -sv ./FreqDivider.sv
vlog -sv ./DPLL.sv
vlog -sv ./top.sv
vlog -sv ./tb.sv

vsim -t 1ns -voptargs="+acc" tb

add wave /tb/clk_i
add wave /tb/reset_i
add wave /tb/signal_i
add wave /tb/signal_o

add wave /tb/top_implementation/dpll/forwarding
add wave /tb/top_implementation/dpll/slowing
add wave /tb/top_implementation/dpll/negativeShift
add wave /tb/top_implementation/dpll/positiveShift
add wave /tb/top_implementation/dpll/phasedSignal

add wave /tb/top_implementation/dpll/filter/kgbM/loadNewValue
add wave /tb/top_implementation/dpll/filter/kgbM/counter
add wave /tb/top_implementation/dpll/filter/kgbM/triggeredMax_o
add wave /tb/top_implementation/dpll/filter/kgbM/triggeredMin_o

add wave /tb/top_implementation/dpll/filter/resetCounter/value_o

add wave /tb/top_implementation/dpll/filter/kgbN/loadNewValue
add wave /tb/top_implementation/dpll/filter/kgbN/counter
add wave /tb/top_implementation/dpll/filter/resetValue
add wave /tb/top_implementation/dpll/filter/kgbN/triggeredMax_o
add wave /tb/top_implementation/dpll/filter/kgbN/triggeredMin_o

add wave /tb/top_implementation/dpll/phaseController/counter
add wave /tb/top_implementation/dpll/phaseController/counterOverflowFlag
add wave /tb/top_implementation/dpll/phaseController/loadingValue

configure wave -timelineunits us
run -all
wave zoom full
