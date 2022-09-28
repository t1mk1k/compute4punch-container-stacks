#!/bin/bash

if [ $# != 1 ]
then
    echo "Specify the indexfiles to download: data2011, data2012, moca2011, moca2012 or single sample"
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
