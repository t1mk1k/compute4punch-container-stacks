#!/bin/bash 

## https://cms-opendata-workshop.github.io/workshop2021-lesson-docker/03-docker-for-cms-opendata/index.html
## https://opendata.cern.ch/record/5500 

if [ $# != 1 ]
  then
    echo "Specify the indexfile to process or \"dev\" for interactive mode"
    exit
fi

indexfile=$1

IFS=/ read -r sample subsample container_name <<< "$indexfile"

WORKDIR=/home/cmsusr/CMSSW_5_3_32/src
ANALYSIS=$WORKDIR/HiggsAnalysis
HOSTDIR=$HOME/H4leptons/container-stacks-h4leptons/h4leptons

output_host=$HOSTDIR/Output
output_container=$WORKDIR/Output

indexfile_host=$HOSTDIR/Indexfiles
indexfile_container=$WORKDIR/Indexfiles

output_mount="-v $output_host:$output_container"
indexfile_mount="-v $indexfile_host:$indexfile_container"

if [[ $1 == "dev" ]]
  then  
    docker run -it  --rm  --name higgs-analysis $output_mount $indexfile_mount h4leptons:latest /bin/bash
  else
    docker run -it  --rm  --name higgs-analysis-$container_name $output_mount $indexfile_mount h4leptons:latest /bin/bash -c "sh $ANALYSIS/analysis.sh $indexfile" 
fi






