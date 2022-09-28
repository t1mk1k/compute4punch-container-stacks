#!/bin/bash

if [ $# != 1 ]
  then
    echo "Specify the sample to retrieve: data2011, data2012, moca2011, moca2012 or single sample"
    exit
fi

eval `oidc-agent`
oidc-add punch-aai
export TOKEN=`oidc-token -f punch-aai`

retrieve_sample=$1

function retrieve_desy() {

SAMPLE=$1
INDEXPATH=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Indexfiles-Splitted
OUTPUTDIR=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Output

echo ""
echo "### retrieving $SAMPLE ###"
echo ""

for file in $INDEXPATH/$SAMPLE/*; do
   file=$(basename $file)
   file=${file//".txt"/}
   file+=".root"
   command="curl -H \"Authorization: Bearer ${TOKEN}\" --output $OUTPUTDIR/$SAMPLE/$file  https://dcache-demo.desy.de:2443/punch/c4p-cern-open-data-demo/$SAMPLE/$file"
   #echo $command
   #echo ""
   eval "$command"
done

echo ""
echo "$SAMPLE has been retrieved successfully"
echo ""
}

if [[ $retrieve_sample = "data2011" ]]
   then
     echo ""
     echo "### retrieving data2011 ###"
     echo ""

     retrieve_desy data2011/Run2011A_DoubleElectron
     retrieve_desy data2011/Run2011A_DoubleMu

elif [[ $retrieve_sample = "data2012" ]]
   then
      echo ""
      echo "### retrieving data2012 ###"
      echo ""

      retrieve_desy data2012/Run2012B_DoubleElectron
      retrieve_desy data2012/Run2012B_DoubleMuParked
      retrieve_desy data2012/Run2012C_DoubleElectron
      retrieve_desy data2012/Run2012C_DoubleMuParked

elif [[ $retrieve_sample = "moca2011" ]]
   then
      echo ""
      echo "### retrieving moca2011 ###"
      echo ""

      retrieve_desy moca2011/DYJetsToLL_M-10To50
      retrieve_desy moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_1  
      retrieve_desy moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_2  
      retrieve_desy moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_3  
      retrieve_desy moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_4  
      retrieve_desy moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_5
      retrieve_desy moca2011/SMHiggsToZZTo4L
      retrieve_desy moca2011/TTTo2L2Nu2B
      retrieve_desy moca2011/ZZTo2e2mu
      retrieve_desy moca2011/ZZTo4e
      retrieve_desy moca2011/ZZTo4mu


elif [[ $retrieve_sample = "moca2012" ]]
   then
      echo ""
      echo "### retrieving moca2012 ###"
      echo ""

      retrieve_desy moca2012/DYJetsToLL_M-10to50_HT-200to400
      retrieve_desy moca2012/DYJetsToLL_M-10to50_HT-400toInf
      retrieve_desy moca2012/DYJetsToLL_M-50
      retrieve_desy moca2012/SMHiggsToZZTo4L
      retrieve_desy moca2012/TTTo2L2Nu2B
      retrieve_desy moca2012/ZZTo2e2mu
      retrieve_desy moca2012/ZZTo4e
      retrieve_desy moca2012/ZZTo4mu

else
   retrieve_desy $retrieve_sample
fi    

unset TOKEN
