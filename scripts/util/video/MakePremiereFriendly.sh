#!/bin/bash
# Check for input
if [ $# -ne 2 ]; then
    echo "[ USAGE ]:" $0 "<input_filename> <output_filename>"
    exit
fi

ffmpeg -i $1 -codec:v utvideo -codec:a pcm_s16le $2
