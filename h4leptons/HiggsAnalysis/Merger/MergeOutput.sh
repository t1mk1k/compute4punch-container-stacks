#!/bin/bash

if [ $# != 1 ]
then
    echo "Supply the sample to merge"
    exit
fi

sample=$1

echo " "
echo "Merging sample $sample"
echo " "

root -l -b -q "MergeOutput.cc(\"$sample\")"

echo " "
echo "Sample $sample has been merged"
echo " "
