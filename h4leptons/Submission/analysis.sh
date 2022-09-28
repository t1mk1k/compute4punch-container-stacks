#!/bin/bash

if [ $# != 2 ]
  then
    echo "Specify the indexfile to process and the sample"
    exit
fi

indexfile=$1
sample=$2

CONDOR=$PWD
TESTFILE=$CONDOR/test.out

CONTAINER_CMSSW=/home/cmsusr/CMSSW_5_3_32/src

WORK=$CONDOR/H4leptons
CMSSW=$WORK/CMSSW_5_3_32/src
ANALYSIS=$CMSSW/HiggsAnalysis
OUTPUT=$CMSSW/Output

source /home/cmsusr/.bashrc      
source /opt/cms/cmsset_default.sh
shopt -s expand_aliases

mkdir $WORK
cd $WORK

cmsrel CMSSW_5_3_32
cd $CMSSW
cmsenv

cp -r $CONTAINER_CMSSW/* $CMSSW
scram b

cd $ANALYSIS

cp $CONDOR/$indexfile $ANALYSIS	   
cp $CONDOR/make-configuration.sh $ANALYSIS
cp $CONDOR/transfer-desy.sh $ANALYSIS

./make-configuration.sh $CONDOR $indexfile
cmsRun analyzer_cfg.py

outputfile=${indexfile//".txt"/}
outputfile+=".root"
./transfer-desy.sh $CONDOR $outputfile https://dcache-demo.desy.de:2443/punch/c4p-cern-open-data-demo/$sample
rm $CONDOR/$outputfile

echo "condor directory: $CONDOR" > $TESTFILE	   
echo "condor directory content: " >> $TESTFILE   
ls $CONDOR >> $TESTFILE			   
echo "" >> $TESTFILE				   
echo "" >> $TESTFILE                             

echo "CMSSW directory: $CMSSW" >> $TESTFILE
echo "CMSSW directory content: " >> $TESTFILE
ls $CMSSW >> $TESTFILE
echo "" >> $TESTFILE
echo "" >> $TESTFILE

echo "ANALYSIS directory: $ANALYSIS" >> $TESTFILE
echo "ANALYSIS directory content: " >> $TESTFILE
ls $ANALYSIS >> $TESTFILE
echo "" >> $TESTFILE
echo "" >> $TESTFILE

echo "configuration file content: " >> $TESTFILE
less analyzer_cfg.py >> $TESTFILE
rm $TESTFILE









