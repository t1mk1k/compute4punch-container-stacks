#!/bin/bash

## https://opendata.cern.ch/record/5500

if [ $# != 1 ]
  then
    echo "Supply the Indexfile to process"
    exit
fi

indexfile=$1

CONTAINER=/home/cmsusr
WORKDIR=/home/cmsusr/CMSSW_5_3_32/src
ANALYSIS=$WORKDIR/HiggsAnalysis

source $CONTAINER/.bashrc
source /opt/cms/cmsset_default.sh

cd $WORKDIR
cmsenv
scram b

cd $ANALYSIS
./make-analyzer-cfg.sh $indexfile
cmsRun analyzer_cfg.py








