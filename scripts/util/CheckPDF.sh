#!/bin/bash
# Check if PDF has all fonts embedded and contains no type 3 fonts
# Usage: $0 <In_PDF_file>

if [ $# -ne 1 ]
then
    echo "Usage: $0 <In_PDF_file>";
    exit;
fi

pdffonts $1
