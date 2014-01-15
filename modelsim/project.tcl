# project.tcl
# create the ModelSim project from scratch in the current directory
#
# usage: vsim -c -do project.tcl

### VARIABLES

set project "observer"

### UTILITY FUNCTIONS

proc project_addglob {globexpr type dstdir} {
    foreach {path} [lsort [glob -nocomplain $globexpr] ] {
        puts "adding $dstdir/[file tail $path]"
        project addfile $path $type $dstdir
    }
}

### MAIN

# make sure user is in the right directory
if { [file tail [pwd]] != "modelsim" || ![file exists project.tcl] } {
    error "please execute project.tcl in the modelsim/ directory"
}

if { [catch "project close"] } {
    # no project was open
}

puts "deleting [pwd]/$project.mpf"
if { [catch "project delete $project.mpf"] } {
    puts "design3.mpf not found, probably running for the first time"
}

puts "creating [pwd]/$project.mpf"
project new . "$project"
project open "$project.mpf"

project addfolder sim
project addfolder src
project addfolder scripts

project_addglob ../vhdl/*.vhd vhdl src
project_addglob ../sim/*.vhd vhdl sim
project_addglob scripts/*.do tcl scripts

puts "compiling project"

#do compile.tcl
project calculateorder
project calculateorder
project calculateorder

puts "project initialized"

