#!/bin/bash
# This script converts any video into Microsoft PowerPoint 2010 friendly WMV files
# [ USAGE ]: $0 <InputFile> <OutputFile>

if [ $# -ne 2 ]; then
    echo "[ USAGE ]: $0 <InputFile> <OutputFile>"
    exit
fi

ffmpeg -i $1 -q:v 4 -c:v wmv2 -c:a wmav2 -b:a 128k $2
