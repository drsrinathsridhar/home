#!/bin/bash
if [ $# -gt 2 ]; then
	echo "[ USAGE ]: $0 [<LogDir=.>] [<PortNumber=2424>]"
	exit
fi

PortNumber=2424
LogDir=.
if [ $# -eq 1 ]; then
    PortNumber=${1}
elif [ $# -eq 2 ]; then
    PortNumber=${1}
    LogDir=${2}
fi

pkill -f "tensorboard --logdir="${LogDir}" --port=${Port}"
