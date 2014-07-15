#!/bin/bash
if [ $# -eq 0 ]
    then
        echo "[ USAGE ]: bash $0 <filename>"
        exit
fi

FILE=$1
ffmpeg -f x11grab -s wxga -r 30 -i :0.0 -sameq ${FILE}
