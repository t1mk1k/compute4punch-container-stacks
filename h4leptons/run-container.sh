#!/bin/bash 

# https://cms-opendata-workshop.github.io/workshop2021-lesson-docker/03-docker-for-cms-opendata/index.html

if [ $# != 1 ]
  then
    echo "Supply the Indexfile to process or \"dev\" for interactive mode"
    exit
fi

indexfile=$1

WORKDIR=/home/cmsusr/CMSSW_5_3_32/src
ANALYSIS=$WORKDIR/HiggsAnalysis

output_host=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Output
output_container=$WORKDIR/Output

if [[ $1 == "dev" ]]
  then  
    docker run -it  --rm  --name higgs-analysis -v $output_host:$output_container h4leptons:latest /bin/bash
  else
    docker run -it  --rm  --name higgs-analysis-$indexfile -v $output_host:$output_container h4leptons:latest /bin/bash -c "sh $ANALYSIS/analysis.sh $indexfile" 
fi






