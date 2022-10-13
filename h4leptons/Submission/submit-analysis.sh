#!/bin/bash 

SUBMISSION=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Submission

if [ $# != 2 ]; then
    echo "Specify the sample to process and the type of job \"prod\" or \"test\""
    echo ""
    echo "data 2011 samples: data2011/Run2011A_DoubleElectron, data2011/Run2011A_DoubleMu"
    echo ""
    echo "data 2012 samples: data2012/Run2012B_DoubleElectron, data2012/Run2012B_DoubleMuParked"
    echo "                   data2012/Run2012C_DoubleElectron, data2012/Run2012C_DoubleMuParked"
    echo ""
    echo "moca 2011 samples: moca2011/ZZTo2e2mu, moca2011/ZZTo4e, moca2011/ZZTo4mu"
    echo "                   moca2011/TTTo2L2Nu2B, moca2011/SMHiggsToZZTo4L"
    echo "                   moca2011/DYJetsToLL_M-10To50, moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_[1-5]"
    echo ""
    echo "moca 2012 samples: moca2012/ZZTo2e2mu, moca2012/ZZTo4e, moca2012/ZZTo4mu"
    echo "                   moca2012/TTTo2L2Nu2B, moca2012/SMHiggsToZZTo4L"
    echo "                   moca2012/DYJetsToLL_M-10to50_HT-200to400, moca2012/DYJetsToLL_M-10to50_HT-400toInf, moca2012/DYJetsToLL_M-50"
    exit
fi

sample="sample=$1"
jobtype=$2

job_option="test=false"

if [[ $jobtype == test ]]; then
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


