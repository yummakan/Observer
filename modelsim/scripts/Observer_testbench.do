
set tb "observer_testbench"

project compileoutofdate

vsim -msgmode both -displaymsgmode both -novopt work.$tb

add wave -hex tau_s
add wave clk_s
add wave reset_s
add wave enable_s
add wave next_obs_s
add wave -color "yellow" phi_s
add wave /observer_testbench/OBS/cycle
add wave /observer_testbench/OBS/count
add wave -color "light blue" output_s

#profile on                  
#set Before [clock seconds]  

run 2000ms
wave zoom full

#set After [clock seconds]
#set total [expr $After - $Before]
#echo "Total Time " $total " Seconds"
#view_profile_ranked     
#profile report -ranked -file profile.txt 



