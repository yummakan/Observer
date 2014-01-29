set tb "multiple_observer_testbench"

project compileoutofdate

vsim -msgmode both -displaymsgmode both -novopt work.$tb

add wave tau_tb
add wave clk_tb
add wave reset_tb
add wave enable_tb
add wave en1
add wave en2
add wave next_obs_tb
add wave -color "yellow" phi_tb 
add wave /multiple_observer_testbench/OBS_1/cycle
add wave add1
add wave /multiple_observer_testbench/OBS_2/cycle
add wave add2
add wave /multiple_observer_testbench/OBS_3/cycle
add wave add3
add wave -color "light blue" output_tb


run 2000ms
wave zoom full
