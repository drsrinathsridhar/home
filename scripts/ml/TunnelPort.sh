#!/bin/bash
# Creates a tunnel from this machine to a remote inside the a closed network
if [ $# -ne 0 ] && [ $# -ne 3 ]; then
    echo "[ USAGE ]: $0 [<UserName=$USER> <HostName=sswks-17-01.stanford.edu> <PortNumber=4242>]"
    exit
fi

UserName=${USER}
HostName=sswks-17-01.stanford.edu
PortNumber=4242

if [ $# -eq 3 ]; then
	UserName=${1}
	HostName=${2}
	PortNumber=${3}
fi

echo "ssh -N -f -L localhost:${PortNumber}:localhost:${PortNumber} ${UserName}@${HostName}"

ssh -N -f -L localhost:${PortNumber}:localhost:${PortNumber} ${UserName}@${HostName}
