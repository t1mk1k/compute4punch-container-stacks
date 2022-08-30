#!/bin/bash

SUBMITDIR=$HOME/H4leptons/container-stacks-h4leptons/h4leptons

$SUBMITDIR/run-container.sh CMS_Run2011A_DoubleElectron_AOD_12Oct2013-v1_20000_file_index.txt
$SUBMITDIR/run-container.sh CMS_Run2011A_DoubleElectron_AOD_12Oct2013-v1_20001_file_index.txt
$SUBMITDIR/run-container.sh CMS_Run2011A_DoubleMu_AOD_12Oct2013-v1_10000_file_index.txt
$SUBMITDIR/run-container.sh CMS_Run2011A_DoubleMu_AOD_12Oct2013-v1_10001_file_index.txt
$SUBMITDIR/run-container.sh CMS_Run2011A_DoubleMu_AOD_12Oct2013-v1_20000_file_index.txt
