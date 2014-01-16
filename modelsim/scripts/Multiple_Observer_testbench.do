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
add wave add1
add wave add2
add wave add3
add wave -color "light blue" output_tb



run -all
wave zoom full
