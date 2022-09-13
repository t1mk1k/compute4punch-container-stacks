#!/bin/bash

#### data 2012
data2012=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Indexfiles/data2012/
WGET="wget --no-check-certificate -P $data2012"

opendata="https://opendata.cern.ch/record"

if [ -z "$(ls $data2012)" ]; then
    
   ###### /DoubleMuParked/Run2012B-22Jan2013-v1/AOD
   $WGET $opendata/6004/files/CMS_Run2012B_DoubleMuParked_AOD_22Jan2013-v1_10000_file_index.txt
   $WGET $opendata/6004/files/CMS_Run2012B_DoubleMuParked_AOD_22Jan2013-v1_20000_file_index.txt
   $WGET $opendata/6004/files/CMS_Run2012B_DoubleMuParked_AOD_22Jan2013-v1_20001_file_index.txt
   $WGET $opendata/6004/files/CMS_Run2012B_DoubleMuParked_AOD_22Jan2013-v1_20002_file_index.txt
   $WGET $opendata/6004/files/CMS_Run2012B_DoubleMuParked_AOD_22Jan2013-v1_210000_file_index.txt

   ###### /DoubleMuParked/Run2012C-22Jan2013-v1/AOD

   $WGET $opendata/6030/files/CMS_Run2012C_DoubleMuParked_AOD_22Jan2013-v1_10000_file_index.txt
   $WGET $opendata/6030/files/CMS_Run2012C_DoubleMuParked_AOD_22Jan2013-v1_10001_file_index.txt
   $WGET $opendata/6030/files/CMS_Run2012C_DoubleMuParked_AOD_22Jan2013-v1_10002_file_index.txt
   $WGET $opendata/6030/files/CMS_Run2012C_DoubleMuParked_AOD_22Jan2013-v1_10003_file_index.txt
   $WGET $opendata/6030/files/CMS_Run2012C_DoubleMuParked_AOD_22Jan2013-v1_10010_file_index.txt

   ###### /DoubleElectron/Run2012B-22Jan2013-v1/AOD

   $WGET $opendata/6003/files/CMS_Run2012B_DoubleElectron_AOD_22Jan2013-v1_20000_file_index.txt
   $WGET $opendata/6003/files/CMS_Run2012B_DoubleElectron_AOD_22Jan2013-v1_20001_file_index.txt
   $WGET $opendata/6003/files/CMS_Run2012B_DoubleElectron_AOD_22Jan2013-v1_30000_file_index.txt

   ###### /DoubleElectron/Run2012C-22Jan2013-v1/AOD

   $WGET $opendata/6029/files/CMS_Run2012C_DoubleElectron_AOD_22Jan2013-v1_20000_file_index.txt
   $WGET $opendata/6029/files/CMS_Run2012C_DoubleElectron_AOD_22Jan2013-v1_20001_file_index.txt
   $WGET $opendata/6029/files/CMS_Run2012C_DoubleElectron_AOD_22Jan2013-v1_20002_file_index.txt
   $WGET $opendata/6029/files/CMS_Run2012C_DoubleElectron_AOD_22Jan2013-v1_20003_file_index.txt
   $WGET $opendata/6029/files/CMS_Run2012C_DoubleElectron_AOD_22Jan2013-v1_20011_file_index.txt

else
   echo "Indexfiles already available for data 2012"
fi
