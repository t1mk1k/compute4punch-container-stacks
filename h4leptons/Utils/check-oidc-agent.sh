#!/bin/bash

FLAAT_INFO=$(flaat-userinfo -o punch-aai 2>&1)

if [[ $FLAAT_INFO == *"Connection refused"* ]] 
then 
   echo "Please define OIDC_SOCK env var and load punch-aai account:"
   echo "eval \`oidc-agent\`"
   echo "oidc-add punch-aai"
   exit

elif [[ $FLAAT_INFO == *"OIDC_SOCK env var not set"* ]]
then
   echo "Please define OIDC_SOCK env var:"
   echo "eval \`oidc-agent\`"
   exit

elif [[ $FLAAT_INFO == *"account not loaded"* ]]
then
   echo "Please load punch-aai account:"
   echo "oidc-add punch-aai"
   exit 

elif [[ $FLAAT_INFO == *"Your token is valid"* ]]
then
   echo "Your token is valid"

else 
   echo "Please set up the mccli virtual environment:"
   echo "source ~/mccli_venv/bin/activate"
   exit 
fi


