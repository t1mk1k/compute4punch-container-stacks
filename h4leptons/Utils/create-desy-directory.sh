#!/bin/bash

if [ $# != 1 ]
  then
    echo "Specify the directory to create on the DESY dCache storage"
    exit
fi

DIRECTORY=$1

CHECK_AGENT="Your token is valid"
UTILS="$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Utils"
CHECK_AGENT=$($UTILS/check-oidc-agent.sh)

if [[ $CHECK_AGENT != "Your token is valid" ]]; then
   $UTILS/check-oidc-agent.sh
   exit
fi

export TOKEN=`oidc-token -f punch-aai`

function mkdir_desy() {
command="curl -X MKDIR -H \"Authorization: Bearer ${TOKEN}\" https://dcache-demo.desy.de:2443/punch/c4p-cern-open-data-demo/$1"
echo $command
echo ""
eval "$command"
}

echo ""
echo "### creating directory punch/c4p-cern-open-data-demo/$DIRECTORY on the DESY dCache storage ###"
echo ""

mkdir_desy $DIRECTORY

unset TOKEN
