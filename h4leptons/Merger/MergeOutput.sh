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

WORKDIR=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Merger

root -l -b -q "$WORKDIR/MergeOutput.cc(\"$sample\")"

echo " "
echo "Sample $sample has been merged"
echo " "
