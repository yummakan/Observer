
set tb "signalgenerator_testbench"

project compileoutofdate

vsim -msgmode both -displaymsgmode both -novopt work.$tb


add wave inputclk
add wave inputreset
add wave -color "yellow" outputsignal
add wave /signalgenerator_top/generator_state
add wave /signalgenerator_top/periodsize
add wave /signalgenerator_top/cnt



#profile on                  
#set Before [clock seconds]  

run 2000ms
wave zoom full

#set After [clock seconds]
#set total [expr $After - $Before]
#echo "Total Time " $total " Seconds"
#view_profile_ranked     
#profile report -ranked -file profile_generator.txt 
