#include "iostream"
#include "fstream"
#include "iomanip"
#include "TROOT.h"

#include "stdlib.h"

#include "TChain.h" 
#include "TFile.h"  
#include "TTree.h"  

#include "TH1.h"
#include "TH1D.h"

#include "TSystem.h"

using namespace std;

vector<string> GetFileList(string directory) {

  char* dir = gSystem->ExpandPathName(TString(directory));
  void* dir_open = gSystem->OpenDirectory(dir);

  const char* file;
  vector<string> filelist;

  while((file = (char*)gSystem->GetDirEntry(dir_open))) {
    if(TString(file).EndsWith(".root")) {      
      filelist.push_back(gSystem->ConcatFileName(dir,file));
    }	
  }
  
  return(filelist);
}

void Merge(string sample) {

  //-- retrieve HOME directory
  const char* home = getenv("HOME");
  
  //-- output directory
  string outputdir_in = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/Output/";
  string outputdir_merged = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/OutputMerged/";

  vector<string> samplelist;

  if(sample == "DoubleMu11") samplelist.push_back("data2011/Run2011A_DoubleMu");
  if(sample == "DoubleE11") samplelist.push_back("data2011/Run2011A_DoubleElectron");

  if(sample == "DoubleMu12") {
    samplelist.push_back("data2012/Run2012B_DoubleMuParked");
    samplelist.push_back("data2012/Run2012C_DoubleMuParked");
  }

  if(sample == "DoubleE12") {
    samplelist.push_back("data2012/Run2012B_DoubleElectron");
    samplelist.push_back("data2012/Run2012C_DoubleElectron");
  }
  
  if(sample == "ZZ4mu11") samplelist.push_back("moca2011/ZZTo4mu");
  if(sample == "ZZ4e11") samplelist.push_back("moca2011/ZZTo4e");
  if(sample == "ZZ2mu2e11") samplelist.push_back("moca2011/ZZTo2e2mu");
  if(sample == "HZZ11") samplelist.push_back("moca2011/SMHiggsToZZTo4L");
  if(sample == "TTBar11") samplelist.push_back("moca2011/TTTo2L2Nu2B");						  
  if(sample == "DY10TuneZ11") samplelist.push_back("moca2011/DYJetsToLL_M-10To50");
  if(sample == "DY50TuneZ11") {
    samplelist.push_back("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_1");
    samplelist.push_back("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_2");
    samplelist.push_back("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_3");
    samplelist.push_back("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_4");
    samplelist.push_back("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_5");
  }

  if(sample == "ZZ4mu12") samplelist.push_back("moca2012/ZZTo4mu");
  if(sample == "ZZ4e12") samplelist.push_back("moca2012/ZZTo4e");
  if(sample == "ZZ2mu2e12") samplelist.push_back("moca2012/ZZTo2e2mu");
  if(sample == "HZZ12") samplelist.push_back("moca2012/SMHiggsToZZTo4L");
  if(sample == "TTBar12") samplelist.push_back("moca2012/TTTo2L2Nu2B");
  if(sample == "DY10TuneZ12") {
    samplelist.push_back("moca2012/DYJetsToLL_M-10to50_HT-200to400");
    samplelist.push_back("moca2012/DYJetsToLL_M-10to50_HT-400toInf");
  }
  if(sample == "DY50TuneZ12") samplelist.push_back("moca2012/DYJetsToLL_M-50");

  
  string file_merged = outputdir_merged + sample + ".root";		       
  
  if(!gSystem->AccessPathName(file_merged.c_str())) {
    for(int isample = 0; isample < samplelist.size(); isample++) {
      cout<<"sample "<<samplelist[isample]<<" already merged"<<endl;
    }
    return;
  }
  
  string command = "hadd " + file_merged;			       

  for(int isample = 0; isample < samplelist.size(); isample++) {
    string dir_file_in = outputdir_in + samplelist[isample];				       
    vector<string> filelist = GetFileList(dir_file_in);		       
    										       
    for(int ifile = 0; ifile < filelist.size(); ifile++) {			       
      command = command + " " + filelist[ifile];   
    }
  }
        
  gSystem->Exec(command.c_str());                                       
  samplelist.clear();
}

int main(int argc, char *argv[]) {

  if(argc!=2)
    {
      cout<<"Specify the sample to merge: data2011, data2012, moca2011, moca2012 or single Monte Carlo sample"<<endl;
      cout<<"Monte Carlo samples 2011: ZZ4mu11, ZZ4e11, ZZ2mu2e11, HZZ11, TTBar11, DY10TuneZ11, DY50TuneZ11"<<endl;
      cout<<"Monte Carlo samples 2012: ZZ4mu12, ZZ4e12, ZZ2mu2e12, HZZ12, TTBar12, DY10TuneZ12, DY50TuneZ12"<<endl;
      exit(0);
    }
  
  string sample=argv[1];
  
  TH1::SetDefaultSumw2(kTRUE);

  //-- retrieve HOME directory
  const char* home = getenv("HOME");

  //-- output directory
  string outputdir_in = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/Output/";
  string outputdir_merged = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/OutputMerged/";

  vector<string> samplelist;
  
  //-----------------//
  //--  data 2011  --//
  //-----------------//

  if(sample == "data2011") {

    //-- DoubleMu 2011
    Merge("DoubleMu11");
    
    //-- DoubleElecton 2011
    Merge("DoubleE11");
  }

  //-----------------//
  //--  data 2012  --//
  //-----------------//
  
  else if(sample == "data2012") {
    
    //-- DoubleMu 2012
    Merge("DoubleMu12");

    //-- DoubleElectron 2012
    Merge("DoubleE12");
  }
 
  
  //------------------------//
  //--  monte carlo 2011  --//
  //------------------------//

  else if(sample == "moca2011") {

    //-- ZZTo4mu 2011
    Merge("ZZ4mu11");
    
    //-- ZZTo4e 2011
    Merge("ZZ4e11");

    //-- ZZTo2e2mu 2011
    Merge("ZZ2mu2e11");

    //-- SMHiggsToZZTo4L 2011
    Merge("HZZ11");

    //-- TTTo2L2Nu2B 2011
    Merge("TTBar11");

    //-- DYJetsToLL_M-10To50 2011
    Merge("DY10TuneZ11");

    //-- DYJetsToLL_M-50 2011
    Merge("DY50TuneZ11");    
  }

  //------------------------//
  //--  monte carlo 2012  --//
  //------------------------//

  else if(sample == "moca2012") {

    //-- ZZTo4mu 2012
    Merge("ZZ4mu12");
    
    //-- ZZTo4e 2012
    Merge("ZZ4e12");
        
    //-- ZZTo2e2mu 2012
    Merge("ZZ2mu2e12");

    //-- SMHiggsToZZTo4L 2012
    Merge("HZZ12");
	  
    //-- TTTo2L2Nu2B 2012
    Merge("TTBar12");

    //-- DYJetsToLL_M-10to50 2012
    Merge("DY10TuneZ12");

    //-- DYJetsToLL_M-50 2012
    Merge("DY50TuneZ12");
  }

  else
    Merge(sample);
}


