#!/bin/bash
# Check for input
if [ $# -ne 4 ]; then
    echo "[ USAGE ]:" $0 "<path_to_dir_name> <file_type> <output_fps> <output_filename>"
    exit
fi

INPUTDIR=${1%/}
IMTYPE=$2
FPS=$3
OUTPUTFNAME=${4}

# Now merge them. Using default good codecs
#mencoder "mf://${INPUTDIR}/*.${IMTYPE}" -mf fps=${INPUTFPS}:type=${IMTYPE} -ovc lavc -lavcopts vcodec=mpeg4:mbd=2:trell:vbitrate=7000 -oac copy -speed 0.1 -o ${OUTPUTFNAME}
cd ${INPUTDIR}
ffmpeg -framerate ${FPS} -pattern_type glob -i "*.${IMTYPE}" -c:v mjpeg ${OUTPUTFNAME}
cd -
