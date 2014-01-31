#!/bin/bash
# [ USAGE ]: bash MountHPS.sh <username>
if [ $# -eq 0 ]
    then
        echo "[ USAGE ]: bash MountHPS.sh <username>"
        exit
fi

USER=$1
sshfs -o ServerAliveInterval=60 -o allow_other ${USER}@contact.mpi-inf.mpg.de:/HPS /HPS
sshfs -o ServerAliveInterval=60 -o allow_other ${USER}@contact.mpi-inf.mpg.de:/home/$1 /home/$1

