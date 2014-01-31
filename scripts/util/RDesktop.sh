#!/bin/bash
# This script is useful for rdesktop-ing to any machine with full colors and fullcreen
# Check for input
if [ $# -ne 2 ]; then
    echo "[ USAGE ]:" $0 "<host_address> [<0_1_isFullscreen_1_default>]"
    exit
fi

Num=1;
if [[ $2 =~ ${Num} ]]; then
    rdesktop -f -a 32 -x l $1
else
    rdesktop -g 1920x1080 -a 32 -x l $1
fi
