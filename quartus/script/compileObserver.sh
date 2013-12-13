#!/bin/sh
LOCATION=..
PROJECT=$LOCATION/InvariantObserver
TOP_LEVEL_FILE=TOP.vhd

# If your Quartus II project exists already, you can just
# recompile the design.
# You can also use the script described in a later example to
# create a new project from scratch
quartus_sh --64bit  --flow compile $PROJECT
