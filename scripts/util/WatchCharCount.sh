#!/bin/bash
# Shows a live count of characters in a file. Useful for word counting for papers.
# Works best when displayed in a separate terminal
# Usage: $0 <Filename>
if [ $# -lt 1 ] || [ $# -gt 2 ];
then
    echo "Usage: $0 <Filename>";
    exit;
fi

watch -t -n 1 "cat ${1} | wc -c"
