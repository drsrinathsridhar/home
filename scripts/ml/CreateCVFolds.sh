#!/bin/bash
# This script creates soft linked cross validation directories for
# easy training and validation.
# Assumptions: Binary classification only for now, the SourceDir
# contains positive and negative samples in respective directories.
# Creates symlinks for all files so may not work on Windows.
# [ USAGE ]: bash CreateFolds.sh <NumFolds> <SourceDir> <DestDir> [<EnableDebug>]
if [ $# -lt 3 ]; then
    echo "[ USAGE ]: bash CreateFolds.sh <NumFolds> <SourceDir> <DestDir> [<EnableDebug = 1>]"
    exit
fi

# Removing trailing slashes from input
NFOLDS=${1}
SRCDIR=${2%/}
DSTDIR=${3%/}
DEBUG=0
if [ $# -eq 4 ]; then
    if [ ${4} -eq 1 ]; then
	DEBUG=1
    fi
fi

# Perform some checks to ensure directory structure
# First check if SRCDIR has pos and neg directories
if [ ! -d "${SRCDIR}/pos" ] || [ ! -d "${SRCDIR}/neg" ]; then
    echo "[ ERROR ]: Source directory does not have the right structure. Unable to continue."
    exit -1
fi
# Next check if destination directory has directories starting with fold
if [ -d "${DSTDIR}/fold1" ]; then
    echo "[ ERROR ]: Destination directory already has directories fold1. Unable to continue."
    exit -2
fi

# First create some directories in destination
for (( c=1; c<=NFOLDS; c++ ))
do
    mkdir ${DSTDIR}/fold$c
    mkdir ${DSTDIR}/fold$c/train
    mkdir ${DSTDIR}/fold$c/train/pos
    mkdir ${DSTDIR}/fold$c/train/neg
    mkdir ${DSTDIR}/fold$c/test
    mkdir ${DSTDIR}/fold$c/test/pos
    mkdir ${DSTDIR}/fold$c/test/neg
done

# Get a count on the number of positive and negative samples in the source directory
# This endures that directories, if any are not included
# Not making any assumptions about the filetype (could be anything with an extension)
POSFILES=(${SRCDIR}/pos/*.*)
NPOS=${#POSFILES[@]}
NEGFILES=(${SRCDIR}/neg/*.*)
NNEG=${#NEGFILES[@]}

# Divide total files neatly based on number of folds
FOLDPOS=$(( NPOS/NFOLDS ))
FOLDNEG=$(( NNEG/NFOLDS ))
FOLDPOSREM=$(( NPOS%NFOLDS )) # Remainder
FOLDNEGREM=$(( NNEG%NFOLDS )) # Remainder

# For debug purposes only
if [ ${DEBUG} -eq 1 ]; then
    echo "[ DEBUG ]: Total positive samples are ${NPOS}"
    echo "[ DEBUG ]: Total negative samples are ${NNEG}"
    echo "[ DEBUG ]: Number of positive samples in each fold are ${FOLDPOS}. Last fold has additional ${FOLDPOSREM} samples."
    echo "[ DEBUG ]: Number of negative samples in each fold are ${FOLDNEG}. Last fold has additional ${FOLDNEGREM} samples."
fi

# Random shuffle file order before creating partitions. 
# $RANDOM % (i+1) is biased because of the limited range of $RANDOM
# Compensate by using a range which is a multiple of the array size.
# local i tmp size max rand
# For positive files
size=${#POSFILES[*]}
max=$(( 32768 / size * size ))
for ((i=size-1; i>0; i--)); do
    while (( (rand=$RANDOM) >= max )); do :; done
    rand=$(( rand % (i+1) ))
    tmp=${POSFILES[i]} POSFILES[i]=${POSFILES[rand]} POSFILES[rand]=$tmp
done
# For negative files
size=${#NEGFILES[*]}
max=$(( 32768 / size * size ))
for ((i=size-1; i>0; i--)); do
    while (( (rand=$RANDOM) >= max )); do :; done
    rand=$(( rand % (i+1) ))
    tmp=${NEGFILES[i]} NEGFILES[i]=${NEGFILES[rand]} NEGFILES[rand]=$tmp
done


# Now create the symlinks for positive samples
#for (( n=1; n<=2; n++ )); do # Number of classes. 2 in case of binary. TODO: Need to handle multiple classes
for (( c=1; c<=NFOLDS; c++ )); do
    TESTSTARTIDX=$(( (c-1)*FOLDPOS + 1 )) # Indices start at 1
    if [ $c -eq ${NFOLDS} ]; then
	TESTENDIDX=$(( ${TESTSTARTIDX} + ${FOLDPOS} + ${FOLDPOSREM} ))
    else
	TESTENDIDX=$(( ${TESTSTARTIDX} + ${FOLDPOS} ))
    fi

    CTR=1
    for FILE in "${POSFILES[@]}"; do
	StrippedFName=$(basename "$FILE")
    	if [ ${CTR} -ge ${TESTSTARTIDX} ] && [ ${CTR} -le ${TESTENDIDX} ]; then
    	    ln -s ${SRCDIR}/pos/"${StrippedFName}" ${DSTDIR}/fold$c/test/pos/"${StrippedFName}" # The ##*/ strips the path preceeding the filename
	    (( CTR++ ))
    	    continue
	else
    	    ln -s ${SRCDIR}/pos/"${StrippedFName}" ${DSTDIR}/fold$c/train/pos/"${StrippedFName}"
	    (( CTR++ ))
    	fi
    done
done


# Now create the symlinks for negative samples
for (( c=1; c<=NFOLDS; c++ )); do
    TESTSTARTIDX=$(( (c-1)*FOLDNEG + 1 )) # Indices start at 1
    if [ $c -eq ${NFOLDS} ]; then
	TESTENDIDX=$(( ${TESTSTARTIDX} + ${FOLDNEG} + ${FOLDNEGREM} ))
    else
	TESTENDIDX=$(( ${TESTSTARTIDX} + ${FOLDNEG} ))
    fi

    CTR=1
    for FILE in "${NEGFILES[@]}"; do
	StrippedFName=$(basename "$FILE")
    	if [ ${CTR} -ge ${TESTSTARTIDX} ] && [ ${CTR} -le ${TESTENDIDX} ]; then
    	    ln -s ${SRCDIR}/neg/"${StrippedFName}" ${DSTDIR}/fold$c/test/neg/"${StrippedFName}" # The ##*/ strips the path preceeding the filename
	    (( CTR++ ))
    	    continue
	else
    	    ln -s ${SRCDIR}/neg/"${StrippedFName}" ${DSTDIR}/fold$c/train/neg/"${StrippedFName}"
	    (( CTR++ ))
    	fi
    done
done
