#!/bin/bash

if [ $# != 1 ]
  then
    echo "Supply the Indexfile to process"
    exit
fi

WORKDIR=/home/cmsusr/CMSSW_5_3_32/src
INDEXPATH=$WORKDIR/Indexfiles
ANALYSIS=$WORKDIR/HiggsAnalysis 


indexfile=$1

outputfile=${indexfile//"_file_index.txt"/}
outputfile+=".root"

pythonfile="analyzer_cfg.py"

echo "import FWCore.ParameterSet.Config as cms" >> $pythonfile
echo "from RecoMuon.TrackingTools.MuonServiceProxy_cff import *" >> $pythonfile
echo "import FWCore.PythonUtilities.LumiList as LumiList" >> $pythonfile
echo "import FWCore.ParameterSet.Types as CfgTypes" >> $pythonfile

echo "" >> $pythonfile
echo "process = cms.Process(\"HiggsAnalysis\")" >> $pythonfile
echo "" >> $pythonfile

echo "process.load(\"FWCore.MessageLogger.MessageLogger_cfi\")" >> $pythonfile
echo "" >> $pythonfile
echo "process.MessageLogger.cerr.FwkReport.reportEvery = 1000" >> $pythonfile
#echo "" >> $pythonfile
#echo "process.MessageLogger.cerr.threshold = 'INFO'" >> $pythonfile
echo "" >> $pythonfile
echo "process.MessageLogger.categories.append('HiggsAnalysis')" >> $pythonfile
#echo "" >> $pythonfile
#echo "process.MessageLogger.cerr.INFO = cms.untracked.PSet(limit = cms.untracked.int32(-1))" >> $pythonfile
echo "" >> $pythonfile
echo "process.options = cms.untracked.PSet(wantSummary = cms.untracked.bool(True))" >> $pythonfile
echo "" >> $pythonfile
echo "process.maxEvents = cms.untracked.PSet(input = cms.untracked.int32(10000))" >> $pythonfile

if [[ $indexfile == *Run2011A* ]] || [[ $indexfile == *Run2012B* ]] || [[ $indexfile == *Run2012C* ]]
  then
    echo ""  >> $pythonfile
    echo "## Good run selection" >> $pythonfile
    echo "" >> $pythonfile
fi

if [[ $indexfile == *Run2011A* ]] 
  then 
    INDEXPATH+="/data2011"
    echo "goodrunlist = '$ANALYSIS/GoodRunList/Cert_160404-180252_7TeV_ReRecoNov08_Collisions11_JSON.txt'" >> $pythonfile
    echo "" >> $pythonfile
    echo "myLumis = LumiList.LumiList(filename = goodrunlist).getCMSSWString().split(',')" >> $pythonfile
elif [[ $indexfile == *Run2012B* ]] || [[ $indexfile == *Run2012C* ]]
  then
    INDEXPATH+="/data2012" 
    echo "goodrunlist = '$ANALYSIS/GoodRunList/Cert_190456-208686_8TeV_22Jan2013ReReco_Collisions12_JSON.txt'" >> $pythonfile
    echo "" >> $pythonfile
    echo "myLumis = LumiList.LumiList(filename = goodrunlist).getCMSSWString().split(',')" >> $pythonfile
fi

if [[ $indexfile == *MonteCarlo2011* ]]					 
  then									 
    INDEXPATH+="/moca2011"
elif [[ $indexfile == *MonteCarlo2012* ]]				 
  then									 
    INDEXPATH+="/moca2012"
fi                                                                       

echo "" >> $pythonfile
echo "## Input data or Montecarlo" >> $pythonfile
echo "" >> $pythonfile
echo "import FWCore.Utilities.FileUtils as FileUtils" >> $pythonfile
echo "" >> $pythonfile
echo "inputfile = FileUtils.loadListFromFile('$INDEXPATH/$indexfile')" >> $pythonfile
echo "" >> $pythonfile
echo "process.source = cms.Source(\"PoolSource\", fileNames = cms.untracked.vstring(*inputfile))" >> $pythonfile

if [[ $indexfile == *Run2011A* ]] || [[ $indexfile == *Run2012B* ]] || [[ $indexfile == *Run2012C* ]]
  then
    echo "" >> $pythonfile
    echo "## Apply good run selection" >> $pythonfile
    echo "" >> $pythonfile
    echo "process.source.lumisToProcess = CfgTypes.untracked(CfgTypes.VLuminosityBlockRange())" >> $pythonfile
    echo "" >> $pythonfile
    echo "process.source.lumisToProcess.extend(myLumis)" >> $pythonfile
fi

Outputdir="Output"
 
if [[ $indexfile == *Run2011A* ]]
  then
    Outputdir+="/data2011"
elif [[ $indexfile == *Run2012B* ]] || [[ $indexfile == *Run2012C* ]]
  then
    Outputdir+="/data2012"
elif [[ $indexfile == *MonteCarlo2011* ]]
  then
    Outputdir+="/moca2011"
elif [[ $indexfile == *MonteCarlo2012* ]]
  then
    Outputdir+="/moca2012"
fi

echo "" >> $pythonfile
echo "## Analyzer" >> $pythonfile
echo "" >> $pythonfile 
echo "process.higgsanalyzer = cms.EDAnalyzer('HiggsAnalyzer')" >> $pythonfile
echo "" >> $pythonfile
echo "process.TFileService = cms.Service(\"TFileService\", fileName = cms.string('$WORKDIR/$Outputdir/$outputfile'))" >> $pythonfile
echo "" >> $pythonfile
echo "process.p = cms.Path(process.higgsanalyzer)" >> $pythonfile
