#!/bin/bash
# Create a list of words in a PDF file and sort them by frequency
# Then write this to a PNG file
# Usage: $0 <Path_to_stopwords_file> <PDF_filename> <OutputImageFile> [<Image_Width = 1024> <Image_Height = 768> <Font-name> <Path_To_Font = sans-serif>]
# NOTE: Needs a stopwords file. Available in ../res or http://skipperkongen.dk/files/english-stopwords-short.txt
# Ack.: http://skipperkongen.dk/2011/09/07/creating-a-word-cloud-from-pdf-documents/
# http://jwalanta.blogspot.de/2010/11/generating-tagcloud-unix-way.html

# TODO: External fonts don't yet work

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


################################
# AWK scripts                  #
################################
MakeCloud='
BEGIN { 
    WIDTH='${WIDTH}'
    HEIGHT='${HEIGHT}'
    SCALE=1
    
    OFS=""
    
    print "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>"
    print "<svg width=\"",WIDTH,"\" height=\"",HEIGHT,"\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\">"
    print "<style type=\"text/css\"> @font-face {'${FONT}'} .customfont {font: '${FONTNAME}';} </style>"
}

{ 
R = int(rand()*9)
G = int(rand()*9)
B = int(rand()*9)

print "<text class=\"customfont\" style=\"fill:#",R,G,B,";opacity:0.75;font-size:",$1*SCALE,"px;\" x=\"",rand()*(WIDTH-100),"\" y=\"",rand()*HEIGHT,"\">",$2,"</text>" 
}

END{ print "</svg>" }'
################################
# End of AWK Scripts           #
################################

# Convert PDF to a hidden file
pdftotext ${IN} raw.txt
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

# Create frequencies list
uniq -c < words.txt | sort -r -n > frequencies.txt

# Truncate upto 500, trim leading whitespace, (then cut) and finally write
head -n500 < frequencies.txt | sed 's/^ *//g' > freqtrunc.txt
#head -n500 < frequencies.txt | sed 's/^ *//g' | cut -f2 -d' ' > freqtrunc.txt

# Create cloud SVG
df | awk "${MakeCloud}" < freqtrunc.txt > ${OUT}.svg

# Convert SVG to PNG
convert ${OUT}.svg ${OUT}

# Cleanup. Delete all except the requested file
rm raw.txt cleaned.txt words.txt frequencies.txt freqtrunc.txt ${OUT}.svg
