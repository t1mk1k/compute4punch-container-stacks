#!/bin/bash

if [ $# != 2 ]; then
    echo "Specify the sample and the splitting number"
    exit
fi

sample=$1
splitting=$2

sample_original=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Indexfiles/$sample
sample_splitted=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Indexfiles-Splitted/$sample

if [ -z "$(ls $sample_original)" ]; then
    echo ""
    echo "$sample: download the indexfiles before attempting to split them"
    echo ""
    exit
fi

declare -i num_indexfiles
num_indexfiles=$(find $sample_splitted -not -type d -and -not -name '.*' | wc -l)

if [[ $num_indexfiles == 0 ]]; then
    
    echo ""
    echo "$sample: splitting indexfiles with a splitting number of $splitting" 
    echo ""
    
    for indexfile in $sample_original/*.txt; do
	
	indexfile_splitted=$sample_splitted/$(basename $indexfile)
	indexfile_splitted=${indexfile_splitted//".txt"/}_ 
	
	if [[ $(uname) == *Linux* ]]; then
            split -l $splitting -d $indexfile $indexfile_splitted --additional-suffix=.txt
	else
	    gsplit -l $splitting -d $indexfile $indexfile_splitted --additional-suffix=.txt
	fi	  
    done
    
    if [[ $sample_splitted == *moca2011/DYJetsToLL_M-50* ]]; then
	n=0
	for file in $sample_splitted/*.txt; do
            SUBDIRECTORY="DYJetsToLL_M-50_sample_$(((n++ / 150)+1))"
            mv $file $sample_splitted/$SUBDIRECTORY/$(basename $file)
	done
    fi 
    
else
    echo "" 
    echo "$sample: splitted indexfiles already available"
    echo ""
fi                                                         
