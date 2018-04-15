#!/bin/bash
if [ $# -gt 1 ]; then
	echo "[ USAGE ]: $0 [PortNumber=4242]"
	exit
fi

PortNumber=4242
if [ $# -eq 1 ]; then
	PortNumber=${1}
fi

pkill -f "jupyter-lab --no-browser --port=${PortNumber}"
