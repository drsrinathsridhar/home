#!/bin/bash
if [ $# -gt 2 ]; then
	echo "[ USAGE ]: $0 [<LogDir=.>] [<PortNumber=2424>]"
	exit
fi

PortNumber="2424"
LogDir="."
if [ $# -eq 1 ]; then
    LogDir=${1}
elif [ $# -eq 2 ]; then
    LogDir=${1}
    PortNumber=${2}
fi

echo "tensorboard --logdir=${LogDir} --port=${PortNumber} &"
tensorboard --logdir="${LogDir}" --port="${PortNumber}" &
