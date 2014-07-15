#!/bin/bash
# This script converts any video into Microsoft PowerPoint 2010 friendly WMV files
# The bitrate is preserved as in the original file
# [ USAGE ]: $0 <InputFile> <OutputFile> <Conversion Quality = [2(best, default) - 5 (worst)]>

if [ $# -lt 2 ] || [ $# -gt 3 ]; then
    echo "Usage: $0 <InputFile> <OutputFile> <Conversion Quality = [2(best, default) - 5 (worst)]>";
    exit;
fi

if [ $# -eq 2 ]; then
    Quality=2
else
    Quality=$3
fi

ffmpeg -i $1 -qscale:v ${Quality} $2
