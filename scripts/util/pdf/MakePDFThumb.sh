#!/bin/bash
# Create a thumbnail with a nice drop shadow of the first page of a PDF file
# Usage: $0 <PDF_filename> <outimage> <outimage_width>

if [ $# -lt 3 ] || [ $# -gt 4 ];
then
    echo "Usage: $0 <PDF_filename> <outimage> <outimage_width> [<drop_shadow = 0,1]";
    exit;
fi

IN=$1
OUT=$2
WIDTH=$3

if [ $# -eq 4 ] && [ ${4} -eq 1 ]; then
    # With shadow
    convert $IN[0] -scale ${WIDTH}x -bordercolor white -border 1 \( +clone -background none -shadow 60x7+3+3 \) +swap -background white -layers merge +repage $OUT
	echo "PDF Thumbnail of width ${WIDTH} created with a drop shadow."
else
    # Without shadow
    convert $IN[0] -scale ${WIDTH}x +swap -background white -layers merge +repage $OUT
	echo "PDF Thumbnail of width ${WIDTH} created WITHOUT a drop shadow."
fi


