#!/bin/bash
# Create a thumbnail from a video file at a given time. Default is first framewith a nice drop shadow of the first page of a PDF file
# Usage: $0 <Video_filename> <outimage_without_extension> [<Time>]

if [ $# -lt 2 ] || [ $# -gt 3 ];
then
    echo "Usage: $0 <Video_filename> <outimage_without_extension> [<Time>]";
    exit;
fi

IN=$1
OUT=$2
TIME=$3
FRAMES=1
#FRAMES=$4 # TODO

if [ $# -eq 3 ]; then
    ffmpeg -ss ${TIME} -i ${IN} -y -f image2 -vcodec mjpeg -vframes ${FRAMES} ${OUT}.jpg
else
    ffmpeg -ss 00:00:01 -i ${IN} -y -f image2 -vcodec mjpeg -vframes ${FRAMES} ${OUT}.jpg
fi


