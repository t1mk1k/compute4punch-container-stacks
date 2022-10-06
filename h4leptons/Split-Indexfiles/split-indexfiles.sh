#!/bin/bash

if [ $# != 2 ]; then
    echo "Specify the sample and the splitting number"
    echo ""
    echo "data 2011 indexfiles: data2011/Run2011A_DoubleElectron, data2011/Run2011A_DoubleMu"
    echo ""
    echo "data 2012 indexfiles: data2012/Run2012B_DoubleElectron, data2012/Run2012B_DoubleMuParked"
    echo "                      data2012/Run2012C_DoubleElectron, data2012/Run2012C_DoubleMuParked"
    echo ""
    echo "moca 2011 indexfiles: moca2011/ZZTo4mu, moca2011/ZZTo4e, moca2011/ZZTo2e2mu"
    echo "                      moca2011/TTTo2L2Nu2B, moca2011/SMHiggsToZZTo4L"
    echo "                      moca2011/DYJetsToLL_M-10To50, moca2011/DYJetsToLL_M-50"
    echo ""
    echo "moca 2012 indexfiles: moca2012/ZZTo4mu, moca2012/ZZTo4e, moca2012/ZZTo2e2mu"
    echo "                      moca2012/TTTo2L2Nu2B, moca2012/SMHiggsToZZTo4L"
    echo "                      moca2012/DYJetsToLL_M-10to50_HT-200to400, moca2012/DYJetsToLL_M-10to50_HT-400toInf, moca2012/DYJetsToLL_M-50"
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
