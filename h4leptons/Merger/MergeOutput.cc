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

void Merge(vector<string> samplelist, string sample_merged) {

  //-- retrieve HOME directory
  const char* home = getenv("HOME");
  
  //-- output directory
  string outputdir_in = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/Output/";
  string outputdir_merged = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/OutputMerged/";
  
  string file_merged = outputdir_merged + sample_merged;		       
  
  if(!gSystem->AccessPathName(file_merged.c_str())) {
    for(int isample = 0; isample < samplelist.size(); i++) {
      cout<<"sample "<<samplelist[isample]<<" already merged"<<endl;
      return;
    }
  }
  
  string command = "hadd " + file_merged;			       

  for(int isample = 0; isample < samplelist.size(); i++) {
    string dir_file_in = outputdir_in + samplelist[isample];				       
    vector<string> filelist = GetFileList(dir_file_in);		       
    										       
    for(int ifile = 0; ifile < filelist.size(); i++) {			       
      command = command + " " + filelist[ifile];   
    }
  }
        
  gSystem->Exec(command.c_str());                                       
}

int main(int argc, char *argv[]) {

  if(argc!=2)
    {
      cout<<"Specify the sample to merge: data2011, data2012, moca2011, moca2012 or single Monte Carlo sample"<<endl;
      exit(0);
    }

  
  string sample=argv[1];
  
  TH1::SetDefaultSumw2(kTRUE);

  //-- retrieve HOME directory
  const char* home = getenv("HOME");

  //-- output directory
  string outputdir_in = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/Output/";
  string outputdir_merged = std::string(home) + "/H4leptons/container-stacks-h4leptons/h4leptons/OutputMerged/";

  //-----------------//
  //--  data 2011  --//
  //-----------------//

  if(sample == "data2011") {

    //-- DoubleMu 2011
    Merge("data2011/Run2011A_DoubleMu/","DoubleMu11.root");

    //-- DoubleElecton 2011
    Merge("data2011/Run2011A_DoubleElectron/","DoubleE11.root");
    
  }

  //-----------------//
  //--  data 2012  --//
  //-----------------//
  
  if(sample == "data2012") {
    
    //-- DoubleMu 2012
    string DoubleMu12 = outputdir_merged + "DoubleMu12.root";	  
    string DoubleMu12B = outputdir_merged + "DoubleMu12B.root";	  
    string DoubleMu12C = outputdir_merged + "DoubleMu12C.root";	  

    if (gSystem->AccessPathName(DoubleMu12.c_str())) {
      
      Merge("data2012/Run2012B_DoubleMuParked/","DoubleMu12B.root");
      Merge("data2012/Run2012C_DoubleMuParked/","DoubleMu12C.root");
      
      string command_DoubleMu12 = "hadd " + DoubleMu12 + " " + DoubleMu12B + " " + DoubleMu12C;
      gSystem->Exec(command_DoubleMu12.c_str());
      gSystem->Exec(TString::Format("rm -f %s", DoubleMu12B.data()));
      gSystem->Exec(TString::Format("rm -f %s", DoubleMu12C.data()));
    }

    else {
      cout<<"sample /data2012/Run2012B_DoubleMuParked already merged"<<endl;
      cout<<"sample /data2012/Run2012C_DoubleMuParked already merged"<<endl;
    }
    
    //-- DoubleElectron 2012
    string DoubleE12 = outputdir_merged + "DoubleE12.root";  
    string DoubleE12B = outputdir_merged + "DoubleE12B.root";
    string DoubleE12C = outputdir_merged + "DoubleE12C.root";
    
    if (gSystem->AccessPathName(DoubleE12.c_str())) {

      Merge("data2012/Run2012B_DoubleElectron/","DoubleE12B.root");
      Merge("data2012/Run2012C_DoubleElectron/","DoubleE12C.root");
  
      string command_DoubleE12 = "hadd " + DoubleE12 + " " + DoubleE12B + " " + DoubleE12C;
      gSystem->Exec(command_DoubleE12.c_str());

      gSystem->Exec(TString::Format("rm -f %s",DoubleE12B.data()));
      gSystem->Exec(TString::Format("rm -f %s",DoubleE12C.data()));		 
    }

    else {
      cout<<"sample /data2012/Run2012B_DoubleElectron/ already merged"<<endl;
      cout<<"sample /data2012/Run2012C_DoubleElectron/ already merged"<<endl;
    }
    
  }

  //------------------------//
  //--  monte carlo 2011  --//
  //------------------------//

  if(sample == "moca2011") {

    //-- ZZTo4mu 2011
    Merge("moca2011/ZZTo4mu/","ZZ4mu11.root");
    
    //-- ZZTo4e 2011
    Merge("moca2011/ZZTo4e/","ZZ4e11.root");

    //-- ZZTo2e2mu 2011
    Merge("moca2011/ZZTo2e2mu/","ZZ2mu2e11.root");
    
    //-- SMHiggsToZZTo4L 2011
    Merge("moca2011/SMHiggsToZZTo4L/","HZZ11.root");

    //-- TTTo2L2Nu2B 2011
    Merge("moca2011/TTTo2L2Nu2B/","TTBar11.root");
    
    //-- DYJetsToLL_M-10To50 2011
    Merge("moca2011/DYJetsToLL_M-10To50/","DY10TuneZ11.root");

    //-- DYJetsToLL_M-50 2011
    string DY50TuneZ11 = outputdir_merged + "DY50TuneZ11.root";
    string DY50TuneZ11_1 = outputdir_merged + "DY50TuneZ11_1.root";
    string DY50TuneZ11_2 = outputdir_merged + "DY50TuneZ11_2.root";
    string DY50TuneZ11_3 = outputdir_merged + "DY50TuneZ11_3.root";
    string DY50TuneZ11_4 = outputdir_merged + "DY50TuneZ11_4.root";
    string DY50TuneZ11_5 = outputdir_merged + "DY50TuneZ11_5.root";

    if (gSystem->AccessPathName(DY50TuneZ11.c_str())) {

      Merge("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_1/","DY50TuneZ11_1.root");
      Merge("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_2/","DY50TuneZ11_2.root");
      Merge("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_3/","DY50TuneZ11_3.root");
      Merge("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_4/","DY50TuneZ11_4.root");
      Merge("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_5/","DY50TuneZ11_5.root");

      string command_DY50TuneZ11 = "hadd " + DY50TuneZ11 + " " + DY50TuneZ11_1 + " " + DY50TuneZ11_2 + " " + DY50TuneZ11_3 + " " + DY50TuneZ11_4 + " " + DY50TuneZ11_5;
      gSystem->Exec(command_DY50TuneZ11.c_str());

      gSystem->Exec(TString::Format("rm -f %s",DY50TuneZ11_1.data()));
      gSystem->Exec(TString::Format("rm -f %s",DY50TuneZ11_2.data()));
      gSystem->Exec(TString::Format("rm -f %s",DY50TuneZ11_3.data()));
      gSystem->Exec(TString::Format("rm -f %s",DY50TuneZ11_4.data()));
      gSystem->Exec(TString::Format("rm -f %s",DY50TuneZ11_5.data()));
    }

    else {
      cout<<"sample /moca2011/DYJetsToLL_M-50/ already merged"<<endl;
    }

  }
  
  //------------------------//
  //--  monte carlo 2012  --//
  //------------------------//

  if(sample == "moca2012") {

    //-- ZZTo4mu 2012
    Merge("moca2012/ZZTo4mu/","ZZ4mu12.root");
    
    //-- ZZTo4e 2012
    Merge("moca2012/ZZTo4e/","ZZ4e12.root");
        
    //-- ZZTo2e2mu 2012
    Merge("moca2012/ZZTo2e2mu/","ZZ2mu2e12.root");

    //-- SMHiggsToZZTo4L 2012
    Merge("moca2012/SMHiggsToZZTo4L/","HZZ12.root");
	  
    //-- TTTo2L2Nu2B 2012
    Merge("moca2012/TTTo2L2Nu2B/","TTBar12.root");

    //-- DYJetsToLL_M-10to50 2012
    string DY10TuneZ12 = outputdir_merged + "DY10TuneZ12.root";
    string DY10TuneZ12_1 = outputdir_merged + "DY10TuneZ12_1.root";
    string DY10TuneZ12_2 = outputdir_merged + "DY10TuneZ12_2.root";

    if (gSystem->AccessPathName(DY10TuneZ12.c_str())) {

      //-- DYJetsToLL_M-10to50_HT-200to400 2012
      Merge("moca2012/DYJetsToLL_M-10to50_HT-200to400/","DY10TuneZ12_1.root");
    
      //-- DYJetsToLL_M-10to50_HT-400toInf 2012
      Merge("moca2012/DYJetsToLL_M-10to50_HT-400toInf/","DY10TuneZ12_2.root");

      string command_DY10TuneZ12 = "hadd " + DY10TuneZ12 + " " + DY10TuneZ12_1 + " " + DY10TuneZ12_2;
      gSystem->Exec(command_DY10TuneZ12.c_str());

      gSystem->Exec(TString::Format("rm -f %s",DY10TuneZ12_1.data()));
      gSystem->Exec(TString::Format("rm -f %s",DY10TuneZ12_2.data()));
    }

    else {
      cout<<"sample /moca2012/DYJetsToLL_M-10to50_HT-200to400/ already merged"<<endl;
      cout<<"sample /moca2012/DYJetsToLL_M-10to50_HT-400toInf/ already merged"<<endl;
    }
    
    //-- DYJetsToLL_M-50 2012
    Merge("moca2012/DYJetsToLL_M-50/","DY50TuneZ12.root");
  }

  //-- ZZTo4mu 2011
  if(sample == "moca2011/ZZTo4mu") 
    Merge("moca2011/ZZTo4mu/","ZZ4mu11.root");

  //-- ZZTo4e 2011                                                                                                                                                                       
  if(sample == "moca2011/ZZTo4e")
    Merge("moca2011/ZZTo4e/","ZZ4e11.root");

  //-- ZZTo2e2mu 2011                                                                                                                                                                    
  if(sample == "moca2011/ZZTo2e2mu")
    Merge("moca2011/ZZTo2e2mu/","ZZ2mu2e11.root");

  //-- SMHiggsToZZTo4L 2011         
  if(sample == "moca2011/SMHiggsToZZTo4L")
    Merge("moca2011/SMHiggsToZZTo4L/","HZZ11.root");

  //-- TTTo2L2Nu2B 2011                                                                                                                                                                  
  if(sample == "moca2011/TTTo2L2Nu2B")
    Merge("moca2011/TTTo2L2Nu2B/","TTBar11.root");

  //-- DYJetsToLL_M-10To50 2011                                                                                                                                                          
  if(sample == "moca2011/DYJetsToLL_M-10To50")
    Merge("moca2011/DYJetsToLL_M-10To50/","DY10TuneZ11.root");

  //-- DYJetsToLL_M-50 2011                                                                                                                                                              
  if(sample == "moca2011/DYJetsToLL_M-50") {
    string DY50TuneZ11 = outputdir_merged + "DY50TuneZ11.root";
    string DY50TuneZ11_1 = outputdir_merged + "DY50TuneZ11_1.root";
    string DY50TuneZ11_2 = outputdir_merged + "DY50TuneZ11_2.root";
    string DY50TuneZ11_3 = outputdir_merged + "DY50TuneZ11_3.root";
    string DY50TuneZ11_4 = outputdir_merged + "DY50TuneZ11_4.root";
    string DY50TuneZ11_5 = outputdir_merged + "DY50TuneZ11_5.root";

    if (gSystem->AccessPathName(DY50TuneZ11.c_str())) {

      Merge("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_1/","DY50TuneZ11_1.root");
      Merge("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_2/","DY50TuneZ11_2.root");
      Merge("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_3/","DY50TuneZ11_3.root");
      Merge("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_4/","DY50TuneZ11_4.root");
      Merge("moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_5/","DY50TuneZ11_5.root");

      string command_DY50TuneZ11 = "hadd " + DY50TuneZ11 + " " + DY50TuneZ11_1 + " " + DY50TuneZ11_2 + " " + DY50TuneZ11_3 + " " + DY50TuneZ11_4 + " " + DY50TuneZ11_5;
      gSystem->Exec(command_DY50TuneZ11.c_str());

      gSystem->Exec(TString::Format("rm -f %s",DY50TuneZ11_1.data()));
      gSystem->Exec(TString::Format("rm -f %s",DY50TuneZ11_2.data()));
      gSystem->Exec(TString::Format("rm -f %s",DY50TuneZ11_3.data()));
      gSystem->Exec(TString::Format("rm -f %s",DY50TuneZ11_4.data()));
      gSystem->Exec(TString::Format("rm -f %s",DY50TuneZ11_5.data()));
    }

    else {
      cout<<"sample /moca2011/DYJetsToLL_M-50/ already merged"<<endl;
    }
  }

  //-- ZZTo4mu 2012                                                                                                                                                                      
  if(sample == "moca2012/ZZTo4mu")
    Merge("moca2012/ZZTo4mu/","ZZ4mu12.root");

  //-- ZZTo4e 2012
  if(sample == "moca2012/ZZTo4e")                                                                                                                                                    
    Merge("moca2012/ZZTo4e/","ZZ4e12.root");

  //-- ZZTo2e2mu 2012                                                                                                                                                                    
  if(sample == "moca2012/ZZTo2e2mu")
    Merge("moca2012/ZZTo2e2mu/","ZZ2mu2e12.root");

  //-- SMHiggsToZZTo4L 2012            
  if(sample == "moca2012/SMHiggsToZZTo4L")
    Merge("moca2012/SMHiggsToZZTo4L/","HZZ12.root");

  //-- TTTo2L2Nu2B 2012                                                                                                                                                                  
  if(sample == "moca2012/TTTo2L2Nu2B")
    Merge("moca2012/TTTo2L2Nu2B/","TTBar12.root");

  //-- DYJetsToLL_M-10to50 2012         
  if(sample == "moca2012/DYJetsToLL_M-10to50") {

    string DY10TuneZ12 = outputdir_merged + "DY10TuneZ12.root";
    string DY10TuneZ12_1 = outputdir_merged + "DY10TuneZ12_1.root";
    string DY10TuneZ12_2 = outputdir_merged + "DY10TuneZ12_2.root";

    if (gSystem->AccessPathName(DY10TuneZ12.c_str())) {

      //-- DYJetsToLL_M-10to50_HT-200to400 2012                                                                                                                                           
      Merge("moca2012/DYJetsToLL_M-10to50_HT-200to400/","DY10TuneZ12_1.root");

      //-- DYJetsToLL_M-10to50_HT-400toInf 2012                                                                                                                                           
      Merge("moca2012/DYJetsToLL_M-10to50_HT-400toInf/","DY10TuneZ12_2.root");

      string command_DY10TuneZ12 = "hadd " + DY10TuneZ12 + " " + DY10TuneZ12_1 + " " + DY10TuneZ12_2;
      gSystem->Exec(command_DY10TuneZ12.c_str());

      gSystem->Exec(TString::Format("rm -f %s",DY10TuneZ12_1.data()));
      gSystem->Exec(TString::Format("rm -f %s",DY10TuneZ12_2.data()));
    }

    else {
      cout<<"sample /moca2012/DYJetsToLL_M-10to50_HT-200to400/ already merged"<<endl;
      cout<<"sample /moca2012/DYJetsToLL_M-10to50_HT-400toInf/ already merged"<<endl;
    }
  }
  
  //-- DYJetsToLL_M-50 2012                                                                                                                                                              
  if(sample == "moca2012/DYJetsToLL_M-50")
    Merge("moca2012/DYJetsToLL_M-50/","DY50TuneZ12.root");
}


