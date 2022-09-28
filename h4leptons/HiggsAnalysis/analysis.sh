#!/bin/bash

if [ $# != 1 ]
  then
    echo "Specify the indexfile to process"
    exit
fi

indexfile=$1

CONTAINER=/home/cmsusr
WORKDIR=$CONTAINER/CMSSW_5_3_32/src
ANALYSIS=$WORKDIR/HiggsAnalysis

source $CONTAINER/.bashrc
source /opt/cms/cmsset_default.sh

cd $WORKDIR
cmsenv
scram b

cd $ANALYSIS
./make-analyzer-cfg.sh $indexfile
cmsRun analyzer_cfg.py








