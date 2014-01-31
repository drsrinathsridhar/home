#!/bin/bash

# Check for input
if [ $# -ne 4 ]; then
    echo "[ USAGE ]:" $0 "<path_to_dir_name> <file_type> <fps> <output_filename>"
    exit
fi

INPUTDIR=${1%/}
IMTYPE=$2
FPS=$3
OUTPUTFNAME=${4}

# # TODO. Mencoder takes care of this now
# if [ ${IMTYPE} != 'jpg' ] || [ ${IMTYPE} != 'png' ];then
#     echo "[ ERROR ]: Unsuported image type. Try jpg or png."
#     exit
# fi

# Now merge them. Using default good codecs
mencoder "mf://${INPUTDIR}/*.${IMTYPE}" -mf fps=${FPS}:type=${IMTYPE} -ovc lavc -lavcopts vcodec=mpeg4:mbd=2:trell:vbitrate=7000 -oac copy -o ${OUTPUTFNAME}
