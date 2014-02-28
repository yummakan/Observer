set tb "multiple_observer_testbench"

project compileoutofdate

vsim -msgmode both -displaymsgmode both -novopt work.$tb

add wave -hex tau_s
add wave clk_s
add wave reset_s
add wave enable_s
add wave en1
add wave en2
add wave next_obs_s
add wave  -color "yellow" phi_s 
add wave  -color "orange" /multiple_observer_testbench/OBS_1/cycle
add wave  -color "orange" /multiple_observer_testbench/OBS_1/count_p
add wave  -color "light blue" add1
add wave  -color "orange" /multiple_observer_testbench/OBS_2/cycle
add wave  -color "orange" /multiple_observer_testbench/OBS_2/count_p
add wave  -color "light blue" add2
add wave  -color "orange" /multiple_observer_testbench/OBS_3/cycle
add wave  -color "orange" /multiple_observer_testbench/OBS_3/count_p
add wave  -color "light blue" add3
add wave  -color "red" output_s


run 2000ms
wave zoom full
