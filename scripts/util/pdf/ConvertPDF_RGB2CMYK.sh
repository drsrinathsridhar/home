#!/bin/bash
# Create a thumbnail with a nice drop shadow of the first page of a PDF file
# Usage: $0 <In_PDF_file> <Out_PDF_file>

if [ $# -ne 2 ]
then
    echo "Usage: $0 <In_PDF_file> <Out_PDF_file>";
    exit;
fi

gs -sDEVICE=pdfwrite -sProcessColorModel=DeviceCMYK -sColorConversionStrategy=CMYK -sColorConversionStrategyForImages=CMYK -o${2}_cmyk.pdf ${1}.pdf
# -dPDFSETTINGS=/prepress
