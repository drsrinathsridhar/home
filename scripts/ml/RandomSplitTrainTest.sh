#!/bin/bash
# This script is for splitting data into train and test sets
# Works only if data is in one file and labels (structured or otherwise)
# are in another file.
# The percentage of train/test samples can be specified
# [ USAGE ]: $0 <Data_File> <Labels_File> <TrainPercent>
if [ $# -ne 3 ]; then
    echo "[ USAGE ]: $0 <Data_File> <Labels_File> <TrainPercent>"
    exit
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
seq 1 ${nTrainLines} | shuf > random_train.txt
seq $(( ${nTrainLines} + 1 )) ${nLines} | shuf > random_test.txt 

paste <(cat random_train.txt) <(head -${nTrainLines} ${DataFile}) | sort | cut -f2- > $(dirname ${DataFile})/TrainData.txt
paste <(cat random_train.txt) <(head -${nTrainLines} ${LabelFile}) | sort | cut -f2- > $(dirname ${DataFile})/TrainLabels.txt

paste <(cat random_test.txt) <(sed -n "$(( ${nTrainLines} + 1 )),${nLines}p" ${DataFile}) | sort | cut -f2- > $(dirname ${DataFile})/TestData.txt
paste <(cat random_test.txt) <(sed -n "$(( ${nTrainLines} + 1 )),${nLines}p" ${LabelFile}) | sort | cut -f2- > $(dirname ${DataFile})/TestLabels.txt

# Cleanup
rm random_*
