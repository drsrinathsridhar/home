#!/bin/bash
# Check for input
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
    echo "[ USAGE ]:" $0 "<video_file> <video_fps> <path_to_output_dir_name>"
    exit
fi

VIDEOFILE=${1}
FPS=${2}
OUTDIR=${3%/}
SEQNAME=${VIDEOFILE##*/}

mkdir -p ${OUTDIR}/frames
ffmpeg -i ${VIDEOFILE} -r ${FPS} -f image2 ${OUTDIR}/frames/${SEQNAME}_frame%07d.png

mkdir -p ${OUTDIR}/audio
ffmpeg -i ${VIDEOFILE} -q:a 0 -map a ${OUTDIR}/audio/${SEQNAME}.mp3
