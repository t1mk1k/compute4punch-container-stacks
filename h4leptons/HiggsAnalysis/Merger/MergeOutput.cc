#include "stdlib.h"
#include "iostream"

#include "TROOT.h" 

#include "TChain.h" 
#include "TFile.h"  
#include "TTree.h"  

#include "TH1.h"
#include "TH1D.h"

void MergeOutput(string sample) {

  TH1::SetDefaultSumw2(kTRUE);

  //-- retrieve HOME directory
  const char* home = getenv("HOME");

  //-----------------//
  //--  data 2011  --//
  //-----------------//

  if(sample == "data2011") {

    string data2011 = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/Output/data2011/";
    string data2011_merged = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/OutputMerged/";

    //-- /DoubleMu/Run2011A-12Oct2013-v1/AOD
    string DoubleMu11A_1 = data2011 + "CMS_Run2011A_DoubleMu_AOD_12Oct2013-v1_10000.root";
    string DoubleMu11A_2 = data2011 + "CMS_Run2011A_DoubleMu_AOD_12Oct2013-v1_10001.root";
    string DoubleMu11A_3 = data2011 + "CMS_Run2011A_DoubleMu_AOD_12Oct2013-v1_20000.root";
    
    string DoubleMu11 = data2011_merged + "DoubleMu11.root";
    
    string command_DoubleMu11 = "hadd " + DoubleMu11 + " " + DoubleMu11A_1 + " " + DoubleMu11A_2 + " " + DoubleMu11A_3;
    gSystem->Exec(command_DoubleMu11.c_str());
  
    //-- /DoubleElectron/Run2011A-12Oct2013-v1/AOD
    string DoubleE11A_1 = data2011 + "CMS_Run2011A_DoubleElectron_AOD_12Oct2013-v1_20000.root";
    string DoubleE11A_2 = data2011 + "CMS_Run2011A_DoubleElectron_AOD_12Oct2013-v1_20001.root";
    
    string DoubleE11 = data2011_merged + "DoubleE11.root";
    
    string command_DoubleE11 = "hadd " + DoubleE11 + " " + DoubleE11A_1 + " " + DoubleE11A_2;
    gSystem->Exec(command_DoubleE11.c_str());
  }

  //-----------------//
  //--  data 2012  --//
  //-----------------//

  if(sample == "data2012") {

    string data2012 = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/Output/data2012/";    
    string data2012_merged = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/OutputMerged/";
    
    //-- /DoubleMuParked/Run2012B-22Jan2013-v1/AOD
    string DoubleMu12B_1 = data2012 + "CMS_Run2012B_DoubleMuParked_AOD_22Jan2013-v1_10000.root";
    string DoubleMu12B_2 = data2012 + "CMS_Run2012B_DoubleMuParked_AOD_22Jan2013-v1_20000.root";
    string DoubleMu12B_3 = data2012 + "CMS_Run2012B_DoubleMuParked_AOD_22Jan2013-v1_20001.root";
    string DoubleMu12B_4 = data2012 + "CMS_Run2012B_DoubleMuParked_AOD_22Jan2013-v1_20002.root";
    string DoubleMu12B_5 = data2012 + "CMS_Run2012B_DoubleMuParked_AOD_22Jan2013-v1_210000.root";
    
    //-- /DoubleMuParked/Run2012C-22Jan2013-v1/AOD
    string DoubleMu12C_1 = data2012 + "CMS_Run2012C_DoubleMuParked_AOD_22Jan2013-v1_10000.root";
    string DoubleMu12C_2 = data2012 + "CMS_Run2012C_DoubleMuParked_AOD_22Jan2013-v1_10001.root";
    string DoubleMu12C_3 = data2012 + "CMS_Run2012C_DoubleMuParked_AOD_22Jan2013-v1_10002.root";
    string DoubleMu12C_4 = data2012 + "CMS_Run2012C_DoubleMuParked_AOD_22Jan2013-v1_10003.root";
    string DoubleMu12C_5 = data2012 + "CMS_Run2012C_DoubleMuParked_AOD_22Jan2013-v1_10010.root";
    
    string DoubleMu12 = data2012_merged + "DoubleMu12.root";

    string command_DoubleMu12B = DoubleMu12B_1 + " " + DoubleMu12B_2 + " " + DoubleMu12B_3 + " " + DoubleMu12B_4 + " " + DoubleMu12B_5;
    string command_DoubleMu12C = DoubleMu12C_1 + " " + DoubleMu12C_2 + " " + DoubleMu12C_3 + " " + DoubleMu12C_4 + " " + DoubleMu12C_5;
    string command_DoubleMu12 = "hadd " + DoubleMu12 + " " + command_DoubleMu12B + " " + command_DoubleMu12C;
    gSystem->Exec(command_DoubleMu12.c_str());
      
    //-- /DoubleElectron/Run2012B-22Jan2013-v1/AOD
    string DoubleE12B_1 = data2012 + "CMS_Run2012B_DoubleElectron_AOD_22Jan2013-v1_20000.root";
    string DoubleE12B_2 = data2012 + "CMS_Run2012B_DoubleElectron_AOD_22Jan2013-v1_20001.root";
    string DoubleE12B_3 = data2012 + "CMS_Run2012B_DoubleElectron_AOD_22Jan2013-v1_30000.root";
    
    //-- /DoubleElectron/Run2012C-22Jan2013-v1/AOD
    string DoubleE12C_1 = data2012 + "CMS_Run2012C_DoubleElectron_AOD_22Jan2013-v1_20000.root";
    string DoubleE12C_2 = data2012 + "CMS_Run2012C_DoubleElectron_AOD_22Jan2013-v1_20001.root";
    string DoubleE12C_3 = data2012 + "CMS_Run2012C_DoubleElectron_AOD_22Jan2013-v1_20002.root";
    string DoubleE12C_4 = data2012 + "CMS_Run2012C_DoubleElectron_AOD_22Jan2013-v1_20003.root";
    string DoubleE12C_5 = data2012 + "CMS_Run2012C_DoubleElectron_AOD_22Jan2013-v1_20011.root";
    
    string DoubleE12 = data2012_merged + "DoubleE12.root";
    
    string command_DoubleE12B = DoubleE12B_1 + " " + DoubleE12B_2 + " " + DoubleE12B_3;
    string command_DoubleE12C = DoubleE12C_1 + " " + DoubleE12C_2 + " " + DoubleE12C_3 + " " + DoubleE12C_4 + " " + DoubleE12C_5;
    string command_DoubleE12 = "hadd " + DoubleE12 + " " + command_DoubleE12B + " " + command_DoubleE12C;
    gSystem->Exec(command_DoubleE12.c_str());
  }
    
  //------------------------//
  //--  monte carlo 2011  --//
  //------------------------//

  if(sample == "moca2011") {

    string moca2011 = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/Output/moca2011/";
    string moca2011_merged = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/OutputMerged/";
    
    //-- /ZZTo4mu_mll4_7TeV-powheg-pythia6/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
    string ZZ4mu11_1 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_ZZTo4mu_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_10000.root";
    string ZZ4mu11_2 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_ZZTo4mu_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_40000.root";
    
    string ZZ4mu11 = moca2011_merged + "ZZ4mu11.root";
    
    string command_ZZ4mu11 = "hadd " + ZZ4mu11 + " " + ZZ4mu11_1 + " " + ZZ4mu11_2; 
    gSystem->Exec(command_ZZ4mu11.c_str());
    
    //-- /ZZTo4e_mll4_7TeV-powheg-pythia6/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
    string ZZ4e11_1 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_ZZTo4e_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_00000.root";
    string ZZ4e11_2 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_ZZTo4e_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_10000.root";
    string ZZ4e11_3 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_ZZTo4e_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_20000.root";
    string ZZ4e11_4 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_ZZTo4e_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_30000.root";
    string ZZ4e11_5 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_ZZTo4e_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_40000.root";
    
    string ZZ4e11 = moca2011_merged + "ZZ4e11.root";
    
    string command_ZZ4e11 = "hadd " + ZZ4e11 + " " + ZZ4e11_1 + " " + ZZ4e11_2 + " " + ZZ4e11_3 + " " + ZZ4e11_4 + " " + ZZ4e11_5;
    gSystem->Exec(command_ZZ4e11.c_str());
    
    //-- /ZZTo2e2mu_mll4_7TeV-powheg-pythia6/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
    string ZZ2mu2e11_1 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_ZZTo2e2mu_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_00000.root";
    string ZZ2mu2e11_2 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_ZZTo2e2mu_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_20000.root";
    string ZZ2mu2e11_3 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_ZZTo2e2mu_mll4_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_40000.root";
    
    string ZZ2mu2e11 = moca2011_merged + "ZZ2mu2e11.root";
    
    string command_ZZ2mu2e11 = "hadd " + ZZ2mu2e11 + " " + ZZ2mu2e11_1 + " " + ZZ2mu2e11_2 + " " + ZZ2mu2e11_3;
    gSystem->Exec(command_ZZ2mu2e11.c_str());
    
    //-- /SMHiggsToZZTo4L_M-125_7TeV-powheg15-JHUgenV3-pythia6/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
    string HZZ11_old = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_SMHiggsToZZTo4L_M-125_7TeV-powheg15-JHUgenV3-pythia6_AODSIM_PU_S13_START53_LV6-v1_20000.root";
    
    string HZZ11_new = moca2011_merged + "HZZ11.root"; 
    
    string command_HZZ11 = "cp " + HZZ11_old + " " + HZZ11_new;
    gSystem->Exec(command_HZZ11.c_str());
    
    //-- /TTTo2L2Nu2B_7TeV-powheg-pythia6/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
    string TTBar11_old = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_TTTo2L2Nu2B_7TeV-powheg-pythia6_AODSIM_PU_S13_START53_LV6-v1_00000.root";
    
    string TTBar11_new = moca2011_merged + "TTBar11.root";
    
    string command_TTBar11 = "cp " + TTBar11_old + " " + TTBar11_new;
    gSystem->Exec(command_TTBar11.c_str());
    
    //-- /DYJetsToLL_M-10To50_TuneZ2_7TeV-pythia6/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
    string DY10TuneZ11_old = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_DYJetsToLL_M-10To50_TuneZ2_7TeV-pythia6_AODSIM_PU_S13_START53_LV6-v1_00000.root";
    
    string DY10TuneZ11_new = moca2011_merged + "DY10TuneZ11.root";
    
    string command_DY10TuneZ11 = "cp " + DY10TuneZ11_old + " " + DY10TuneZ11_new;
    gSystem->Exec(command_DY10TuneZ11.c_str());
    
    //-- /DYJetsToLL_M-50_7TeV-madgraph-pythia6-tauola/Summer11LegDR-PU_S13_START53_LV6-v1/AODSIM
    string DY50TuneZ11_1 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_DYJetsToLL_M-50_7TeV-madgraph-pythia6-tauola_AODSIM_PU_S13_START53_LV6-v1_00000.root";
    string DY50TuneZ11_2 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_DYJetsToLL_M-50_7TeV-madgraph-pythia6-tauola_AODSIM_PU_S13_START53_LV6-v1_00001.root";
    string DY50TuneZ11_3 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_DYJetsToLL_M-50_7TeV-madgraph-pythia6-tauola_AODSIM_PU_S13_START53_LV6-v1_00002.root";
    string DY50TuneZ11_4 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_DYJetsToLL_M-50_7TeV-madgraph-pythia6-tauola_AODSIM_PU_S13_START53_LV6-v1_010000.root";
    string DY50TuneZ11_5 = moca2011 + "CMS_MonteCarlo2011_Summer11LegDR_DYJetsToLL_M-50_7TeV-madgraph-pythia6-tauola_AODSIM_PU_S13_START53_LV6-v1_010001.root";
    
    string DY50TuneZ11 = moca2011_merged + "DY50TuneZ11.root";
    
    string command_DY50TuneZ11 = "hadd " + DY50TuneZ11 + " " + DY50TuneZ11_1 + " " + DY50TuneZ11_2 + " " + DY50TuneZ11_3 + " " + DY50TuneZ11_4 + " " + DY50TuneZ11_5;
    gSystem->Exec(command_DY50TuneZ11.c_str());
  }

  //------------------------//
  //--  monte carlo 2012  --//
  //------------------------//

  if(sample == "moca2012") {

    string moca2012 = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/Output/moca2012/";
    string moca2012_merged = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/OutputMerged/";
    
    //-- /ZZTo4mu_8TeV-powheg-pythia6/Summer12_DR53X-PU_RD1_START53_V7N-v1/AODSIM
    string ZZ4mu12_old = moca2012 + "CMS_MonteCarlo2012_Summer12_DR53X_ZZTo4mu_8TeV-powheg-pythia6_AODSIM_PU_RD1_START53_V7N-v1_20000.root";

    string ZZ4mu12_new = moca2012_merged + "ZZ4mu12.root";
    
    string command_ZZ4mu12 = "cp " + ZZ4mu12_old + " " + ZZ4mu12_new;
    gSystem->Exec(command_ZZ4mu12.c_str());
    
    //-- /ZZTo4e_8TeV-powheg-pythia6/Summer12_DR53X-PU_RD1_START53_V7N-v2/AODSIM
    string ZZ4e12_old = moca2012 + "CMS_MonteCarlo2012_Summer12_DR53X_ZZTo4e_8TeV-powheg-pythia6_AODSIM_PU_RD1_START53_V7N-v2_20000.root";
    
    string ZZ4e12_new = moca2012_merged + "ZZ4e12.root";
    
    string command_ZZ4e12 = "cp " + ZZ4e12_old + " " + ZZ4e12_new;
    gSystem->Exec(command_ZZ4e12.c_str());
    
    //-- /ZZTo2e2mu_8TeV-powheg-pythia6/Summer12_DR53X-PU_RD1_START53_V7N-v2/AODSIM
    string ZZ2mu2e12_old = moca2012 + "CMS_MonteCarlo2012_Summer12_DR53X_ZZTo2e2mu_8TeV-powheg-pythia6_AODSIM_PU_RD1_START53_V7N-v2_10000.root";
    
    string ZZ2mu2e12_new = moca2012_merged + "ZZ2mu2e12.root";
    
    string command_ZZ2mu2e12 = "cp " + ZZ2mu2e12_old + " " + ZZ2mu2e12_new;
    gSystem->Exec(command_ZZ2mu2e12.c_str());
    
    //-- /SMHiggsToZZTo4L_M-125_8TeV-powheg15-JHUgenV3-pythia6/Summer12_DR53X-PU_S10_START53_V19-v1/AODSIM
    string HZZ12_old = moca2012 + "CMS_MonteCarlo2012_Summer12_DR53X_SMHiggsToZZTo4L_M-125_8TeV-powheg15-JHUgenV3-pythia6_AODSIM_PU_S10_START53_V19-v1_10000.root";
    
    string HZZ12_new = moca2012_merged + "HZZ12.root";
    
    string command_HZZ12 = "cp " + HZZ12_old + " " + HZZ12_new;
    gSystem->Exec(command_HZZ12.c_str());

    //-- /TTbar_8TeV-Madspin_aMCatNLO-herwig/Summer12_DR53X-PU_S10_START53_V19-v2/AODSIM
    string TTBar12_1 = moca2012 + "CMS_MonteCarlo2012_Summer12_DR53X_TTbar_8TeV-Madspin_aMCatNLO-herwig_AODSIM_PU_S10_START53_V19-v2_00000.root";
    string TTBar12_2 = moca2012 + "CMS_MonteCarlo2012_Summer12_DR53X_TTbar_8TeV-Madspin_aMCatNLO-herwig_AODSIM_PU_S10_START53_V19-v2_20000.root";
    
    string TTBar12 = moca2012_merged + "TTBar12.root";
    
    string command_TTBar12 = "hadd " + TTBar12 + " " + TTBar12_1 + " " + TTBar12_2;
    gSystem->Exec(command_TTBar12.c_str());

    //-- /DYJetsToLL_M-10to50_HT-200to400_TuneZ2star_8TeV-madgraph-tauola/Summer12_DR53X-PU_S10_START53_V19-v1/AODSIM
    string DY10TuneZ12_1 = moca2012 + "CMS_MonteCarlo2012_Summer12_DR53X_DYJetsToLL_M-10to50_HT-200to400_TuneZ2star_8TeV-madgraph-tauola_AODSIM_PU_S10_START53_V19-v1_00000.root";
    string DY10TuneZ12_2 = moca2012 + "CMS_MonteCarlo2012_Summer12_DR53X_DYJetsToLL_M-10to50_HT-200to400_TuneZ2star_8TeV-madgraph-tauola_AODSIM_PU_S10_START53_V19-v1_30000.root";
    
    //-- /DYJetsToLL_M-10to50_HT-400toInf_TuneZ2star_8TeV-madgraph-tauola/Summer12_DR53X-PU_S10_START53_V19-v1/AODSIM
    string DY10TuneZ12_3 = moca2012 + "CMS_MonteCarlo2012_Summer12_DR53X_DYJetsToLL_M-10to50_HT-400toInf_TuneZ2star_8TeV-madgraph-tauola_AODSIM_PU_S10_START53_V19-v1_00000.root";
    string DY10TuneZ12_4 = moca2012 + "CMS_MonteCarlo2012_Summer12_DR53X_DYJetsToLL_M-10to50_HT-400toInf_TuneZ2star_8TeV-madgraph-tauola_AODSIM_PU_S10_START53_V19-v1_30000.root";
    
    string DY10TuneZ12 = moca2012_merged + "DY10TuneZ12.root";
    
    string command_DY10TuneZ12 = "hadd " + DY10TuneZ12 + " " + DY10TuneZ12_1 + " " + DY10TuneZ12_2 + " " + DY10TuneZ12_3 + " " + DY10TuneZ12_4;
    gSystem->Exec(command_DY10TuneZ12.c_str());
    
    //-- /DYJetsToLL_M-50_TuneZ2Star_8TeV-madgraph-tarball-tauola-tauPolarOff/Summer12_DR53X-PU_S10_START53_V19-v1/AODSIM
    string DY50TuneZ12_1 = moca2012 + "CMS_MonteCarlo2012_Summer12_DR53X_DYJetsToLL_M-50_TuneZ2Star_8TeV-madgraph-tarball-tauola-tauPolarOff_AODSIM_PU_S10_START53_V19-v1_00000.root";
    string DY50TuneZ12_2 = moca2012 + "CMS_MonteCarlo2012_Summer12_DR53X_DYJetsToLL_M-50_TuneZ2Star_8TeV-madgraph-tarball-tauola-tauPolarOff_AODSIM_PU_S10_START53_V19-v1_00001.root";
    
    string DY50TuneZ12 = moca2012_merged + "DY50TuneZ12.root";
    
    string command_DY50TuneZ12 = "hadd " + DY50TuneZ12 + " " + DY50TuneZ12_1 + " " + DY50TuneZ12_2;
    gSystem->Exec(command_DY50TuneZ12.c_str());
  }
}









