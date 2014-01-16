
set tb "observer_testbench"

project compileoutofdate

vsim -msgmode both -displaymsgmode both -novopt work.$tb

add wave tau_tb
add wave clk_tb
add wave reset_tb
add wave enable_tb
add wave next_obs_tb
add wave -color "yellow" phi_tb
#add wave /observer_testbench/OBS/cycle
add wave /observer_testbench/OBS/count
add wave -color "light blue" output_tb



run -all
wave zoom full

