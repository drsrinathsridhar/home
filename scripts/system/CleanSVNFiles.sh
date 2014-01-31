#!/bin/bash
# [ USAGE ]: bash CleanSVNFiles.sh
if [ $# -eq 0 ]; then
        echo "[ USAGE ]: bash MountHPS.sh <SourceDir> [<List (0 - default) | Delete (1 - must be forced)>]"
        exit
fi

SRCDIR=${1%/}
if [ $# -eq 2 ]; then
    PRINT=$2
else
    PRINT=0
fi

if (( PRINT == 0 )); then
    find ${SRCDIR} -name .svn -exec echo '{}' \;
else
    find ${SRCDIR} -name .svn -exec echo '{}' \;
    find ${SRCDIR} -name .svn -exec rm -rf '{}' \;
fi
