#/bin/bash
# Generate paper writing statistics
# Usage: $0 <Path/TeX_File> [<Number_of_Target_Pages = 10>]
# NOTE: Depends on other scripts usually in PWD

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
TIC="$(date +%s)"

if [ $# -lt 1 ] || [ $# -gt 2 ];
then
    echo "Usage: $0 <Path/TeX_File> [<Number_of_Target_Pages = 10>]";
    exit;
fi

NumPages=10
if [ $# -eq 2 ]; then
    NumPages=$2
fi

FileName="${1##*/}"
BaseFileName="${FileName%.*}"
FilePath="${1%/*}"

# cd to FilePath
cd ${FilePath}

pdflatex ${BaseFileName}.tex
bibtex ${BaseFileName}.bib
pdflatex ${BaseFileName}.tex
pdflatex ${BaseFileName}.tex

# Create paper statistics. Works only on Srinath's machine!
clear
echo "Done building LaTeX. Will attempt to build statistics for current paper version. Be patient this will take some time."
# First take a snapshot of the paper and archive it
NOW=$(date +"%Y-%m-%d_%H%M")
mkdir -p ${FilePath}/progress/snapshot
# Also select pages. ImageMagick is 0-indexed
ActualPages=$(pdfinfo ${BaseFileName}.pdf | grep Pages | sed 's/[^0-9]*//')
if [ ${ActualPages} -ge ${NumPages} ]; then
    montage -density 1000 ${BaseFileName}.pdf[0-$(( ${NumPages} - 1 ))] -mode Concatenate -tile $(( ${NumPages}/2 ))x2 -quality 80 -resize 800 ${FilePath}/progress/snapshot/${NOW}.png
else
    echo "[ WARN ]: Less than ${NumPages} pages in built PDF. Please check."
    montage -density 1000 ${BaseFileName}.pdf -mode Concatenate -tile $(( (${ActualPages} - 1)/2 ))x2 -quality 80 -resize 800 ${FilePath}/progress/snapshot/${NOW}.png
fi
# Make directory if it doesn't exist then copy stuff
mkdir -p ${FilePath}/progress/archive
cp ${BaseFileName}.pdf ${FilePath}/progress/archive/${NOW}.pdf

# Create a two tag cloud versions. One with the same random seed and the other more beautiful
mkdir -p ${FilePath}/progress/tagcloud1
bash ${HOME}/scripts/util/pdf/MakePDFTagCloud.sh ${HOME}/scripts/res/stopwords.txt ${BaseFileName}.pdf ${FilePath}/progress/tagcloud1/${NOW}.png 1000 300
# New better looking python tag cloud
mkdir -p ${FilePath}/progress/tagcloud2
bash ${HOME}/scripts/util/pdf/MakePDFTagCloud2.sh ${HOME}/scripts/res/stopwords.txt ${BaseFileName}.pdf ${FilePath}/progress/tagcloud2/${NOW}.png 1000 300

# Write out number of words by appending to file
pdftotext ${BaseFileName}.pdf - | wc -w >> ${FilePath}/progress/WordCount.txt

# Write out timestamps to file
echo ${NOW} >> ${FilePath}/progress/TimeStamps.txt

# Clean temp files. This increases build time but is worth to keep directory clean.
rm *.log *.aux *.out

# cd back to original directory
cd -

TOC="$(date +%s)"
echo "All done in $((TOC-TIC)) seconds!"
