#!/bin/bash

#### Monte Carlo 2012
moca2012=$HOME/H4leptons/container-stacks-h4leptons/h4leptons/Indexfiles/moca2012/
WGET="wget --no-check-certificate -P $moca2012"

opendata="https://opendata.cern.ch/record"

if [ -z "$(ls $moca2012)" ]; then
    
   ###### /ZZTo4mu_8TeV-powheg-pythia6/Summer12_DR53X-PU_RD1_START53_V7N-v1/AODSIM
   $WGET $opendata/10071/files/CMS_MonteCarlo2012_Summer12_DR53X_ZZTo4mu_8TeV-powheg-pythia6_AODSIM_PU_RD1_START53_V7N-v1_20000_file_index.txt

   ###### /ZZTo4e_8TeV-powheg-pythia6/Summer12_DR53X-PU_RD1_START53_V7N-v2/AODSIM
   $WGET $opendata/10065/files/CMS_MonteCarlo2012_Summer12_DR53X_ZZTo4e_8TeV-powheg-pythia6_AODSIM_PU_RD1_START53_V7N-v2_20000_file_index.txt

   ###### /ZZTo2e2mu_8TeV-powheg-pythia6/Summer12_DR53X-PU_RD1_START53_V7N-v2/AODSIM
   $WGET $opendata/10054/files/CMS_MonteCarlo2012_Summer12_DR53X_ZZTo2e2mu_8TeV-powheg-pythia6_AODSIM_PU_RD1_START53_V7N-v2_10000_file_index.txt

   ###### /SMHiggsToZZTo4L_M-125_8TeV-powheg15-JHUgenV3-pythia6/Summer12_DR53X-PU_S10_START53_V19-v1/AODSIM
   $WGET $opendata/9356/files/CMS_MonteCarlo2012_Summer12_DR53X_SMHiggsToZZTo4L_M-125_8TeV-powheg15-JHUgenV3-pythia6_AODSIM_PU_S10_START53_V19-v1_10000_file_index.txt

   ###### /TTbar_8TeV-Madspin_aMCatNLO-herwig/Summer12_DR53X-PU_S10_START53_V19-v2/AODSIM
   $WGET $opendata/9518/files/CMS_MonteCarlo2012_Summer12_DR53X_TTbar_8TeV-Madspin_aMCatNLO-herwig_AODSIM_PU_S10_START53_V19-v2_00000_file_index.txt
   $WGET $opendata/9518/files/CMS_MonteCarlo2012_Summer12_DR53X_TTbar_8TeV-Madspin_aMCatNLO-herwig_AODSIM_PU_S10_START53_V19-v2_20000_file_index.txt

   ###### /DYJetsToLL_M-10to50_HT-200to400_TuneZ2star_8TeV-madgraph-tauola/Summer12_DR53X-PU_S10_START53_V19-v1/AODSIM
   $WGET $opendata/7727/files/CMS_MonteCarlo2012_Summer12_DR53X_DYJetsToLL_M-10to50_HT-200to400_TuneZ2star_8TeV-madgraph-tauola_AODSIM_PU_S10_START53_V19-v1_00000_file_index.txt
   $WGET $opendata/7727/files/CMS_MonteCarlo2012_Summer12_DR53X_DYJetsToLL_M-10to50_HT-200to400_TuneZ2star_8TeV-madgraph-tauola_AODSIM_PU_S10_START53_V19-v1_30000_file_index.txt

   ###### /DYJetsToLL_M-10to50_HT-400toInf_TuneZ2star_8TeV-madgraph-tauola/Summer12_DR53X-PU_S10_START53_V19-v1/AODSIM
   $WGET $opendata/7728/files/CMS_MonteCarlo2012_Summer12_DR53X_DYJetsToLL_M-10to50_HT-400toInf_TuneZ2star_8TeV-madgraph-tauola_AODSIM_PU_S10_START53_V19-v1_00000_file_index.txt
   $WGET $opendata/7728/files/CMS_MonteCarlo2012_Summer12_DR53X_DYJetsToLL_M-10to50_HT-400toInf_TuneZ2star_8TeV-madgraph-tauola_AODSIM_PU_S10_START53_V19-v1_30000_file_index.txt

   ###### /DYJetsToLL_M-50_TuneZ2Star_8TeV-madgraph-tarball-tauola-tauPolarOff/Summer12_DR53X-PU_S10_START53_V19-v1/AODSIM
   $WGET $opendata/7731/files/CMS_MonteCarlo2012_Summer12_DR53X_DYJetsToLL_M-50_TuneZ2Star_8TeV-madgraph-tarball-tauola-tauPolarOff_AODSIM_PU_S10_START53_V19-v1_00000_file_index.txt
   $WGET $opendata/7731/files/CMS_MonteCarlo2012_Summer12_DR53X_DYJetsToLL_M-50_TuneZ2Star_8TeV-madgraph-tarball-tauola-tauPolarOff_AODSIM_PU_S10_START53_V19-v1_00001_file_index.txt 

else
   echo "Indexfiles already available for Monte Carlo 2012"
fi
