#!/bin/bash
# This script converts any video into Microsoft PowerPoint 2010 friendly WMV files
# The bitrate is preserved as in the original file
# [ USAGE ]: $0 <InputFile> <OutputFile>

if [ $# -ne 2 ]; then
    echo "[ USAGE ]: $0 <InputFile> <OutputFile>"
    exit
fi

ffmpeg -i $1 -sameq -y -vf scale=-1:360 $2
