set tb "ten_observer_testbench"

project compileoutofdate

vsim -msgmode both -displaymsgmode both -novopt work.$tb

add wave -hex tau_s
add wave clk_s
add wave reset_s
add wave enable_s
add wave en1
add wave en2
add wave en3
add wave en4
add wave en5
add wave en6
add wave en7
add wave en8
add wave en9
add wave next_obs_s
add wave  -color "yellow" phi_s 
add wave  -color "orange" /ten_observer_testbench/OBS_0/cycle
add wave  -color "orange" /ten_observer_testbench/OBS_0/count_p
add wave  -color "light blue" add(0)
add wave  -color "orange" /ten_observer_testbench/OBS_1/cycle
add wave  -color "orange" /ten_observer_testbench/OBS_1/count_p
add wave  -color "light blue" add(1)
add wave  -color "orange" /ten_observer_testbench/OBS_2/cycle
add wave  -color "orange" /ten_observer_testbench/OBS_2/count_p
add wave  -color "light blue" add(2)

add wave  -color "orange" /ten_observer_testbench/OBS_3/cycle
add wave  -color "orange" /ten_observer_testbench/OBS_3/count_p
add wave  -color "light blue" add(3)

add wave  -color "orange" /ten_observer_testbench/OBS_4/cycle
add wave  -color "orange" /ten_observer_testbench/OBS_4/count_p
add wave  -color "light blue" add(4)

add wave  -color "orange" /ten_observer_testbench/OBS_5/cycle
add wave  -color "orange" /ten_observer_testbench/OBS_5/count_p
add wave  -color "light blue" add(5)

add wave  -color "orange" /ten_observer_testbench/OBS_6/cycle
add wave  -color "orange" /ten_observer_testbench/OBS_6/count_p
add wave  -color "light blue" add(6)

add wave  -color "orange" /ten_observer_testbench/OBS_7/cycle
add wave  -color "orange" /ten_observer_testbench/OBS_7/count_p
add wave  -color "light blue" add(7)

add wave  -color "orange" /ten_observer_testbench/OBS_8/cycle
add wave  -color "orange" /ten_observer_testbench/OBS_8/count_p
add wave  -color "light blue" add(8)

add wave  -color "orange" /ten_observer_testbench/OBS_9/cycle
add wave  -color "orange" /ten_observer_testbench/OBS_9/count_p
add wave  -color "light blue" add(9)

add wave  -color "red" output_s



run 2000ms
wave zoom full
