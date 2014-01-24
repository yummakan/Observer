#!/usr/bin/python
#Kommentare
###############################################################################
# Todo: python script must be extended to overwrite Observer.vhd
#      ,because of GENERIC_MAP
##############################################################################

name  = raw_input ("Dateiname des Top VHDL Files:")
number = int(raw_input ("Wieviele Observer?:"))


################## OVERVIEW ######################

##### area0 ########

#code...

##### <begin_0>###########

# put my code here

######<end_0>############
##### area1 ########

#code...

##### <begin_1>###########

# put my code here

######<end_1>############
##### area2 ########

#code...

##### <begin_2>###########

# put my code here

######<end_2>############
##### area3 ########

#code...

##### <begin_3>###########

# put my code here

######<end_3>############
##### area4 ########


#code..


############### END OF FILE ##################


##default string representations###

obs_component_begin="FOR OBS_"
obs_component_end  =" : observer \n  use entity  work.observer(Behavioural);\n"

area0="\n"
area1="\n"
area2="\n"
area3="\n"
area4="\n"

signal_add_begin   = "signal add"
signal_enable_begin= "signal en"  # number always begins with 1 and ends with number-1
				#no enable signal for the first observer and the last observer
signal_end         = "	    :std_logic:='0';\n"

port_map_first     = "OBS_" #number of observer
port_map_second    = ":  observer GENERIC MAP(observernumber => x" + '"' # hardcode number of obs
port_map_third     = '"'+")\n    PORT MAP ( output=>add" #output obs to signal add
port_map_fourth    = ",clk=>clk_s,reset =>reset_s, enable_in =>" # number of enable signal to the next obs (first is always enable_s) 
port_map_fifth     = ",invariance_tau => tau_s,signal_phi=> phi_s,enable_out=>" # observer enable the next observer ()
port_map_sixth    =  ") ;\n"

output_begin = "	output_s <= ("
output_first = "add"
output_next= " and add"
output_end = ");\n"

string_begin0="<BEGIN_0>" 
string_end0  ="<END_0>"
string_begin1="<BEGIN_1>" 
string_end1  ="<END_1>"
string_begin2="<BEGIN_2>" 
string_end2  ="<END_2>"
string_begin3="<BEGIN_3>" 
string_end3  ="<END_3>"

# useful functions to generate appropriate text
def create_obs_list():
    result=""
    for i in range(number):
        result= result + obs_component_begin + str(i) + obs_component_end
    return result


def create_signals():
    
    list1= signal_add_begin + str(0) + signal_end
    list2= ""
    for i in range(1,number):
        list1 = list1 + signal_add_begin + str(i) + signal_end
        list2 = list2 + signal_enable_begin + str(i) + signal_end
    return (list1 + list2)

def create_port_map():
    #numberobs = '{%04X}'.format(number,base='X') 
    numberobs='{num:04X}'.format(num=number)
    result=""
    for i in range(number-1):
        result=result + port_map_first + str(i) + port_map_second # number of current obs
        result=result +  numberobs     # hardcode number of obs
        result = result + port_map_third + str(i) #  PORT MAP ( output=>add(number) ...)
        if i == 0:
             result = result + port_map_fourth + "enable_s"
        else:
            result = result + port_map_fourth +"en"+ str(i)#  # number of enable signal to the next obs (first is always enable_s) 
        result = result + port_map_fifth +"en"+ str(i+1) + port_map_sixth
    if((number-1)>0):
        result=result +port_map_first + str(number-1) + port_map_second # number of current obs
        result=result +  numberobs    # hardcode number of obs
        result = result + port_map_third + str(number-1) #  PORT MAP ( output=>add(number) ...)
        result = result + port_map_fourth +"en"+ str(number-1)#  # number of enable signal to the next obs (first is always enable_s) 
        result = result + port_map_fifth + " next_obs_s" + port_map_sixth
    else:
        result=result +port_map_first + str(number-1) + port_map_second # number of current obs
        result=result +  numberobs    # hardcode number of obs
        result = result + port_map_third + str(number-1) #  PORT MAP ( output=>add(number) ...)
        result = result + port_map_fourth + "enable_s"#  # number of enable signal to the next obs (first is always enable_s) 
        result = result + port_map_fifth + " next_obs_s" + port_map_sixth  
    
    return result


def create_output():
    result=output_begin
    result = result + output_first
    for i in range(number-1):
        result = result + str(i) + output_next
    result = result + str(number-1) + output_end
    return result


# state machine       
a = True
a1= False
b = False
b1= False
c  =False
c1 =False
d = False
d1= False
e = False

# string representation of the whole file

string_final=""

######## MAIN ROUTINE  ################

## start reading the whole file
fname = open(name,"r")
for line in fname:
    if a==True:
        if line.find(string_begin0)!= -1:
            area0 = area0 + line
            a1=True
        elif a1==True:
            if line.find(string_end0)!=-1:
                area1 = area1 + line
                a1=False
                a=False
                b=True
            else:
                continue
        else:
            area0 = area0 + line
    elif b==True:
        if line.find(string_begin1)!= -1:
            area1 = area1 + line
            b1=True
        elif b1==True:
            if line.find(string_end1)!=-1:
                area2 = area2 + line
                b1=False
                b=False
                c=True
            else:
                continue
        else:
            area1 = area1 + line
    elif c==True:
        if line.find(string_begin2)!= -1:
            area2 = area2 + line
            c1=True
        elif c1==True:
            if line.find(string_end2)!=-1:
                area3 = area3 + line
                c1=False
                c=False
                d=True
            else:
                continue
        else:
            area2 = area2 + line
    elif d==True:
        if line.find(string_begin3)!= -1:
            area3 = area3 + line
            d1=True
        elif d1==True:
            if line.find(string_end3)!=-1:
                area4 = area4 + line
                d1=False
                d=False
                e=True
            else:
                continue
        else:
            area3 = area3 + line 
    elif e==True:
        area4 = area4 + line       
    else:
        print "ERROR in control flow"

fname.close()  

#start writing the result to the Top Vhdl file
string_final = string_final + area0
string_final = string_final + create_obs_list() 
string_final = string_final + area1
string_final = string_final + create_signals() 
string_final = string_final + area2
string_final = string_final + create_port_map()
string_final = string_final + area3
string_final = string_final + create_output()
string_final = string_final + area4

fname = open(name,"w")
fname.write(string_final)
#print string_final
fname.close()


