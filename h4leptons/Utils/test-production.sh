#!/bin/bash

INDEX_PATH=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Indexfiles-Splitted
LOG_PATH=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Submission/logs

CHECK_AGENT="Your token is valid"
UTILS="$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Utils"
CHECK_AGENT=$($UTILS/check-oidc-agent.sh)

if [[ $CHECK_AGENT != "Your token is valid" ]]; then
   $UTILS/check-oidc-agent.sh
   exit
fi

export TOKEN=`oidc-token -f punch-aai`

function list_desy() {
command="curl -LS -H \"Authorization: Bearer ${TOKEN}\" https://dcache-demo.desy.de:2443/punch/c4p-cern-open-data-demo/$1 2>&1 | grep root | wc -l"
eval "$command"
}

function check() {

sample=$1

index_num=0
log_num=0

if [ -z "$(ls $INDEX_PATH/$sample)" ]; then
   return 0
fi


if [ -z "$(ls $LOG_PATH/$sample)" ]; then
   return 0
fi

echo ""		      
echo "### $sample ###"
echo ""               

if ! [ -z "$(ls $INDEX_PATH/$sample)" ]; then	     
    index_num=$(ls $INDEX_PATH/$sample/*.txt | wc -l)
fi

if ! [ -z "$(ls $LOG_PATH/$sample)" ]; then
   log_num=$(less $LOG_PATH/$sample/*.log | grep "own accord" | wc -l)
fi

message="NOT YET DONE"

if [ $index_num = $log_num ]; then
   message="DONE"
fi

desy_num=`list_desy $sample`
desy_num=$(($desy_num/2))

echo "indexfiles = $index_num - logfiles = $log_num - desy storage = $desy_num - $message"
echo ""

}

### data2011 ###

check data2011/Run2011A_DoubleElectron
check data2011/Run2011A_DoubleMu

### data2012 ###

check data2012/Run2012B_DoubleElectron
check data2012/Run2012B_DoubleMuParked

check data2012/Run2012C_DoubleElectron
check data2012/Run2012C_DoubleMuParked

### moca2011 ###

check moca2011/DYJetsToLL_M-10To50 
check moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_1
check moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_2
check moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_3
check moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_4
check moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_5
check moca2011/SMHiggsToZZTo4L 
check moca2011/TTTo2L2Nu2B 
check moca2011/ZZTo2e2mu 
check moca2011/ZZTo4e 
check moca2011/ZZTo4mu 

### moca2012 ###

check moca2012/DYJetsToLL_M-10to50_HT-200to400 
check moca2012/DYJetsToLL_M-10to50_HT-400toInf 
check moca2012/DYJetsToLL_M-50 
check moca2012/SMHiggsToZZTo4L 
check moca2012/TTTo2L2Nu2B 
check moca2012/ZZTo2e2mu 
check moca2012/ZZTo4e 
check moca2012/ZZTo4mu 




