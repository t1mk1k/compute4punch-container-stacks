#!/bin/bash

#### data 2011
data2011=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/HiggsAnalysis/Indexfiles/data2011/
WGET="wget --no-check-certificate -P $data2011"

opendata="https://opendata.cern.ch/record"

if [ -z "$(ls -A $data2011)" ]; then
   
   ###### /DoubleMu/Run2011A-12Oct2013-v1/AOD 
   $WGET $opendata/17/files/CMS_Run2011A_DoubleMu_AOD_12Oct2013-v1_10000_file_index.txt
   $WGET $opendata/17/files/CMS_Run2011A_DoubleMu_AOD_12Oct2013-v1_10001_file_index.txt
   $WGET $opendata/17/files/CMS_Run2011A_DoubleMu_AOD_12Oct2013-v1_20000_file_index.txt

   ###### /DoubleElectron/Run2011A-12Oct2013-v1/AOD
   $WGET $opendata/16/files/CMS_Run2011A_DoubleElectron_AOD_12Oct2013-v1_20000_file_index.txt
   $WGET $opendata/16/files/CMS_Run2011A_DoubleElectron_AOD_12Oct2013-v1_20001_file_index.txt

else
   echo "Indexfiles already available for data 2011"
fi
   


