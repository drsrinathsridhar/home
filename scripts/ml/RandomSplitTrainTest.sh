#!/bin/bash
# This script is for splitting data into train and test sets
# Works only if data is in one file and labels (structured or otherwise)
# are in another file.
# The percentage of train/test samples can be specified
# [ USAGE ]: $0 <Data_File> <Labels_File> <TrainPercent>
if [ $# -lt 3 ] || [ $# -gt 4 ]; then
    echo "[ USAGE ]: $0 <Data_File> <Labels_File> <TrainPercent> [<RandomizeTestLabels = 0 (default) | 1>]"
    exit
fi

if [ $# -eq 4 ] && [ $4 -eq 1 ]; then
    isRandomizeTest=1
else
    isRandomizeTest=0
fi
DataFile=$1
LabelFile=$2
nLines=$(wc -l ${DataFile} | cut -f1 -d' ')
TrainPercent=$3
nTrainLines=$(( ${nLines} * ${TrainPercent} / 100 ))
echo "Creating ${nTrainLines} training samples."
nTestLines=$(( ${nLines} - ${nTrainLines} ))
echo "Creating ${nTestLines} testing samples."

# First generate a sequence of numbers and shuffle it to get random indices within range
if [ ${isRandomizeTest} -eq 1 ]; then
    echo "Randomizing test labels."
    seq 1 ${nLines} | shuf > random.txt
else
    echo "NOT randomizing test labels."
    seq 1 ${nTrainLines} | shuf > random.txt
    seq $(( ${nTrainLines} + 1 )) ${nLines} >> random.txt
fi

paste <(cat random.txt) <(cat ${DataFile}) | sort -n | head -${nTrainLines} | cut -f2- > $(dirname ${DataFile})/TrainData.txt
paste <(cat random.txt) <(cat ${LabelFile}) | sort -n | head -${nTrainLines} | cut -f2- > $(dirname ${LabelFile})/TrainLabels.txt

paste <(cat random.txt) <(cat ${DataFile}) | sort -n | sed -n "$(( ${nTrainLines} + 1 )),${nLines}p" | cut -f2- > $(dirname ${DataFile})/TestData.txt
paste <(cat random.txt) <(cat ${LabelFile}) | sort -n | sed -n "$(( ${nTrainLines} + 1 )),${nLines}p" | cut -f2- > $(dirname ${LabelFile})/TestLabels.txt

# Cleanup
rm random.txt
