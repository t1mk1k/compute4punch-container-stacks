#!/bin/bash 

if [ $# != 3 ]
  then
    echo "Specify the HTCondor directory, the outputfile and the storage"
    exit
fi

CONDOR=$1
OUTPUTFILE=$2
STORAGE=$3

TOKEN=$(cat $CONDOR/token.txt)
transfer_command="curl -L -X PUT -H \"Authorization: Bearer ${TOKEN}\" --upload-file $CONDOR/$OUTPUTFILE $STORAGE/$OUTPUTFILE"
eval "$transfer_command"

#echo ""				       
#echo "token = $TOKEN"			       
#echo ""				       
#echo "condor directory = $CONDOR" 	       
#echo ""				       
#echo "outputfile = $OUTPUTFILE"	       
#echo ""				       
#echo "storage = $STORAGE"		       
#echo ""                                       
#echo "transfer command = $transfer_command"                                                                        
#echo ""





