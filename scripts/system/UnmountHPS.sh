#!/bin/bash
# [ USAGE ]: bash MountHPS.sh <username>
if [ $# -eq 0 ]
    then
        echo "[ USAGE ]: bash MountHPS.sh <username>"
        exit
fi

USER=$1
fusermount -u /HPS
fusermount -u /home/${USER}
