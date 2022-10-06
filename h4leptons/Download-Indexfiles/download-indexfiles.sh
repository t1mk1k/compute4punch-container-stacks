#!/bin/bash

if [ $# != 1 ]
then
   echo "Specify the indexfiles to download: data2011, data2012, moca2011, moca2012 or a specific indexfile"
   echo ""
   echo "data 2011 indexfiles: data2011/Run2011A_DoubleMu, data2011/Run2011A_DoubleElectron"
   echo ""
   echo "data 2012 indexfiles: data2012/Run2012B_DoubleMuParked, data2012/Run2012C_DoubleMuParked, data2012/Run2012B_DoubleElectron, data2012/Run2012C_DoubleElectron"
   echo ""
   echo "moca 2011 indexfiles: moca2011/ZZTo4mu, moca2011/ZZTo4e, moca2011/ZZTo2e2mu"
   echo "                      moca2011/TTTo2L2Nu2B, moca2011/SMHiggsToZZTo4L"
   echo "                      moca2011/DYJetsToLL_M-10To50, moca2011/DYJetsToLL_M-50"
   echo ""
   echo "moca 2012 indexfiles: moca2012/ZZTo4mu, moca2012/ZZTo4e, moca2012/ZZTo2e2mu"
   echo "                      moca2012/TTTo2L2Nu2B, moca2012/SMHiggsToZZTo4L"
   echo "                      moca2012/DYJetsToLL_M-10to50_HT-200to400, moca2012/DYJetsToLL_M-10to50_HT-400toInf, moca2012/DYJetsToLL_M-50"
   exit
fi

sample=$1    
Indexfiles="$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Indexfiles/"
database="$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Download-Indexfiles/list-sample.txt"

while read -r database_sample database_index; do
   if [[ $database_sample == *$sample* ]]; then
      if ! [ -z "$(ls $Indexfiles/$database_sample)" ]; then
	 echo "Indexfiles already available for $sample"
	 exit 0
      fi
   fi
done < "$database"

list_sample=()
list_index=()

while read -r database_sample database_index; do
   WGET="wget --no-check-certificate -P $Indexfiles"
   if [[ $database_sample == *$sample* ]]; then
      database_index=${database_index/opendata/"https://opendata.cern.ch/record"}
      WGET="$WGET$database_sample $database_index"
      $WGET
   fi
done < "$database"
