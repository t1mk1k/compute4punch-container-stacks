#!/bin/bash 

SUBMISSION=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Submission

if [ $# != 2 ]
  then
    echo "Specify the sample to process and the type of job  \"prod\" or \"test\""
    exit
fi

sample="sample=$1"
jobtype=$2

job_option="test=false"

if [[ $jobtype == test ]] 
then
    job_option="test=true"
fi


if ! [[ -f $SUBMISSION/token.txt ]]; then
   eval `oidc-agent`
   oidc-add punch-aai

   TOKEN="`oidc-token -f punch-aai`" 
   echo $TOKEN > token.txt
fi

echo "submission: condor_submit $job_option $sample analysis.jdl"
exec condor_submit $job_option $sample analysis.jdl


