#!/bin/bash

#### Monte Carlo 2011
moca2011=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/HiggsAnalysis/Indexfiles/moca2011/
WGET="wget --no-check-certificate -P $moca2011"

opendata="https://opendata.cern.ch/record"

if [ -z "$(ls -A $moca2011)" ]; then
    
   ###### /ZZTo4mu_mll4_7TeV-powheg-pythia6/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
   $WGET $opendata/1651/files/CMS_MonteCarlo2011_Summer11LegDR_ZZTo4mu_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_10000_file_index.txt
   $WGET $opendata/1651/files/CMS_MonteCarlo2011_Summer11LegDR_ZZTo4mu_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_40000_file_index.txt

   ###### /ZZTo4e_mll4_7TeV-powheg-pythia6/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
   $WGET $opendata/1648/files/CMS_MonteCarlo2011_Summer11LegDR_ZZTo4e_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_00000_file_index.txt
   $WGET $opendata/1648/files/CMS_MonteCarlo2011_Summer11LegDR_ZZTo4e_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_10000_file_index.txt
   $WGET $opendata/1648/files/CMS_MonteCarlo2011_Summer11LegDR_ZZTo4e_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_20000_file_index.txt
   $WGET $opendata/1648/files/CMS_MonteCarlo2011_Summer11LegDR_ZZTo4e_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_30000_file_index.txt
   $WGET $opendata/1648/files/CMS_MonteCarlo2011_Summer11LegDR_ZZTo4e_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_40000_file_index.txt

   ###### /ZZTo2e2mu_mll4_7TeV-powheg-pythia6/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
   $WGET $opendata/1382/files/CMS_MonteCarlo2011_Summer11LegDR_ZZTo2e2mu_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_00000_file_index.txt
   $WGET $opendata/1382/files/CMS_MonteCarlo2011_Summer11LegDR_ZZTo2e2mu_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_20000_file_index.txt
   $WGET $opendata/1382/files/CMS_MonteCarlo2011_Summer11LegDR_ZZTo2e2mu_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_40000_file_index.txt

   ###### /TTTo2L2Nu2B_7TeV-powheg-pythia6/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
   $WGET $opendata/1360/files/CMS_MonteCarlo2011_Summer11LegDR_TTTo2L2Nu2B_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_00000_file_index.txt

   ###### /DYJetsToLL_M-10To50_TuneZ2_7TeV-pythia6/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
   $WGET $opendata/1393/files/CMS_MonteCarlo2011_Summer11LegDR_DYJetsToLL_M-10To50_TuneZ2_7TeV-pythia6_AODSIM_PU_S13_START53_LV6-v1_00000_file_index.txt

   ###### /DYJetsToLL_M-50_7TeV-madgraph-pythia6-tauola/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
   $WGET $opendata/1394/files/CMS_MonteCarlo2011_Summer11LegDR_DYJetsToLL_M-50_7TeV-madgraph-pythia6-tauola_AODSIM_PU_S13_START53_LV6-v1_00000_file_index.txt
   $WGET $opendata/1394/files/CMS_MonteCarlo2011_Summer11LegDR_DYJetsToLL_M-50_7TeV-madgraph-pythia6-tauola_AODSIM_PU_S13_START53_LV6-v1_00001_file_index.txt
   $WGET $opendata/1394/files/CMS_MonteCarlo2011_Summer11LegDR_DYJetsToLL_M-50_7TeV-madgraph-pythia6-tauola_AODSIM_PU_S13_START53_LV6-v1_00002_file_index.txt
   $WGET $opendata/1394/files/CMS_MonteCarlo2011_Summer11LegDR_DYJetsToLL_M-50_7TeV-madgraph-pythia6-tauola_AODSIM_PU_S13_START53_LV6-v1_010000_file_index.txt
   $WGET $opendata/1394/files/CMS_MonteCarlo2011_Summer11LegDR_DYJetsToLL_M-50_7TeV-madgraph-pythia6-tauola_AODSIM_PU_S13_START53_LV6-v1_010001_file_index.txt

   ###### /SMHiggsToZZTo4L_M-125_7TeV-powheg15-JHUgenV3-pythia6/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
   $WGET $opendata/1507/files/CMS_MonteCarlo2011_Summer11LegDR_SMHiggsToZZTo4L_M-125_7TeV-powheg15-JHUgenV3-pythia6_AODSIM_PU_S13_START53_LV6-v1_20000_file_index.txt

else
   echo "Indexfiles already available for Monte Carlo 2011"
fi

