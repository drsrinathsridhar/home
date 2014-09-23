#!/bin/bash
# NOTE: This is version 2 and uses an external python library
# https://github.com/amueller/word_cloud
# Create a list of words in a PDF file and sort them by frequency
# Then write this to a PNG file
# Usage: $0 <Path_to_stopwords_file> <PDF_filename> <OutputImageFile> [<Image_Width = 1024> <Image_Height = 768> <Font-name> <Path_To_Font = sans-serif>]
# NOTE: Needs a stopwords file. Available in ../res or http://skipperkongen.dk/files/english-stopwords-short.txt
# Ack.: http://skipperkongen.dk/2011/09/07/creating-a-word-cloud-from-pdf-documents/
# http://jwalanta.blogspot.de/2010/11/generating-tagcloud-unix-way.html

if [ $# -lt 3 ] || [ $# -gt 7 ] || (( $# == 4 )) || (( $# == 6 ));
then
    echo "Usage: $0 <Path_to_stopwords_file> <PDF_filename> <OutputImageFile> [<Image_Width> <Image_Height> <Font-name> <Path_To_Font>]";
    exit;
fi

STOPWORDS=$1
IN=$2
OUT=$3
if (( $# == 3 ));
then
    WIDTH=1024
    HEIGHT=768
else
    WIDTH=$4
    HEIGHT=$5
fi

if (( $# == 7 ));
then
    FONT="font-family: '$6', sans-serif;src: url($7) format("truetype");"
    FONTNAME="$6"
#    echo ${FONT}
else
    FONT="font-family:'sans-serif';"
    FONTNAME="sans-serif"
fi

# Convert PDF to a hidden file
# Convert ligatures such as fi to ASCII
pdftotext -enc ASCII7 ${IN} raw.txt
perl -lpe s/[^[:print:]]+//g raw.txt >> cleaned.txt # Clean and keep only printable chars

# Keep only characters, make them lower case, put each word on a line, remove stopwords and some garbage. Sort them for good measure:
cat cleaned.txt | \
sed 's/[^a-zA-Z]/ /g' | \
tr '[:upper:]' '[:lower:]' | \
tr ' ' '
' | \
sed '/^$/d' | \
sed '/^[a-z]$/d' | \
grep -v -w -f ${STOPWORDS} | \
sort > words.txt

# Pass this to python file
python ${HOME}/scripts/util/pdf/MakeTagCloud.py ${PWD}/words.txt ${OUT} ${WIDTH} ${HEIGHT}

# Cleanup. Delete all except the requested file
rm raw.txt cleaned.txt words.txt
