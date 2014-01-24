#!/usr/bin/python
#Kommentare

name  = raw_input ("Dateiname des Top VHDL Files:")
number = int(raw_input ("Wieviele Observer?:"))

##default string representations###
obs_component_begin="FOR OBS_"
obs_component_end  =" : observer \n  use entity  work.observer(Behavioural);"

signal_add_begin   = "signal add"
signal_enable_begin= "signal en"
signal_end         = "	    :std_logic:='0';"

port_map_first     = "OBS_ " #number of observer
port_map_second    = "  observer GENERIC MAP(observernumber => x" + '"' # hardcode number of obs
port_map_third     = '"'+")\n    PORT MAP ( output=>add" #output obs to signal add
port_map_fourth    = ",	clk=>clk_s,reset =>reset_s, enable_in => enable_s,invariance_tau => tau_s,signal_phi=> phi_s,enable_out=> en" # observer enable the next observer
port_map_fifth    =  ") ;\n"

output_begin = "	output_s <= ("
output_first = "add"
output_next= " and add"
output_end = ");\n"

def create_output():
    result=output_begin
    rsult = result + output_first
    for i in range(number):
        


fname = open(name,"r+")
for line in fname:
    line.strip()
    if line.find("<BEGIN_4>"):
        print "Found <BEGIN_4>"
  
#print number
