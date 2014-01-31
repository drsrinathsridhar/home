#!/bin/bash
# [ USAGE ]: bash CleanSVNFiles.sh <Directory_Path> <Print_Only>=[0 (default) | 1]
if [ $# -gt 2 ] || [ $# -lt 1 ]; then
        echo "[ USAGE ]: bash CleanSVNFiles.sh <Directory_Path> <Print_Only>=[0 (default) | 1]"
        exit
fi

SRCDIR=${1%/}
if [ $# -eq 2 ]; then
    PRINT=$2
else
    PRINT=0
fi

if (( PRINT == 0 )); then
    echo "Found SVN files: (Please use the 1 for the second argument to delete) "
    find ${SRCDIR} -name .svn -exec echo '{}' \;
else
    echo "Deleting: "
    find ${SRCDIR} -name .svn -exec echo '{}' \;
    find ${SRCDIR} -name .svn -exec rm -rf '{}' \;
fi
