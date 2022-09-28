#!/bin/bash

if [ $# != 1 ]
  then
    echo "Specify the directory to delete on the DESY dCache storage"
    exit
fi

DIRECTORY=$1

eval `oidc-agent`
oidc-add punch-aai
export TOKEN=`oidc-token -f punch-aai`

function delete_desy() {
command="curl -X DELETE -H \"Authorization: Bearer ${TOKEN}\" https://dcache-demo.desy.de:2443/punch/c4p-cern-open-data-demo/$1"
echo $command
echo ""
eval "$command"
}

echo ""
echo "### deleting directory punch/c4p-cern-open-data-demo/$DIRECTORY on the DESY dCache storage ###"
echo ""

delete_desy $DIRECTORY

unset TOKEN
