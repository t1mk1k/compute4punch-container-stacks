#!/bin/bash 

if [ $# != 2 ]
  then
    echo "Supply the sample to process and the type of job  \"prod\" or \"test\""
    exit
fi

sample="'sample=$1'"
jobtype=$2

job_option="'test=false'"
if [[ $jobtype == test ]] 
  then
    job_option="'test=true'"
fi

eval `oidc-agent-service start`
oidc-add punch-aai   
echo "eval `oidc-token punch-aai`" > token.txt

echo "--> condor_submit $job_option $sample analysis-h4leptons.jdl"
