# Higgs Analysis Container

This project implements in a container the code developped by N.Z. Jomhari, A. Geiser and A. Anuar. and later adapted for github by F. Blekman.
This code is a strongly simplified reimplementation of parts of the original CMS Higgs-to-four-lepton analysis published in [Phys.Lett. B716 (2012) 30-61, 
arXiv:1207.7235](https://inspirehep.net/record/1124338?ln=en). The code can be found on the [CERN Open Data portal](http://opendata.cern.ch/record/5500)  
while the modified version adapted for github can be found in the [HiggsExample20112012 repository](https://github.com/cms-opendata-analyses/HiggsExample20112012/). 
In this container implementation, only the Level 4 exercise described in the [CERN Open Data portal](http://opendata.cern.ch/record/5500) 
and in the [github repository](https://github.com/cms-opendata-analyses/HiggsExample20112012/) is considered. 

# Modifications implemented in the container version

With respect to the software available in the [github repository](https://github.com/cms-opendata-analyses/HiggsExample20112012/), the container version implements
the following modifications:
* Use of a docker container with the CMSSW release CMSSW_5_3_32 instead of a CERN Virtual Machine to run the analysis.
* Availability of scripts for direct dowload of the indexfiles corresponding to the data sets and Monte Carlo used in the analysis.
* Availability of a script for the building of configuration files for different data sets and Monte Carlo.
* Possibility to easily submit the production on a batch system.

# Brief description of the analysis strategy

The simplified reimplementation of parts of the CMS Higgs-to-four-lepton analysis is considering the "4 muons" and "2 muons 2 electrons" final states 
from the DoubleMuParked datasets and the "4 electrons" final state from the DoubleElectron dataset in order to avoid a double counting that would be
introduced by overlapping triggers. All Monte Carlo contributions except the minor top anti-top background are using data-driven normalization.
The Drell-Yan (Z/gamma^*) contribution is scaled to the data in the Z peak region. The ZZ contribution is scaled to describe the data in the independent mass range 
180-600 GeV. The Higgs contribution is scaled to describe the data in the signal region. The very small top contribution remains scaled to the Monte Carlo generator 
cross section. More details about the analysis can be found in the [CERN Open Data portal](http://opendata.cern.ch/record/5500) 
and in the [HiggsExample20112012 repository](https://github.com/cms-opendata-analyses/HiggsExample20112012/).     

# Instructions to test the analysis locally

1. Create the directory `H4leptons`:

```
mkdir $HOME/H4leptons
cd $HOME/H4leptons
```

2. Clone the [gitlab repository](https://gitlab-p4n.aip.de/compute4punch/container-stacks/-/tree/main/h4leptons):

```
git clone https://gitlab-p4n.aip.de/compute4punch/container-stacks.git
```

3. Dowload the indexfiles corresponding to the data sets and Monte Carlo for 2011 and 2012: 

```
cd container-stacks/h4leptons
./Download-Indexfiles/download-indexfiles.sh data2011
./Download-Indexfiles/download-indexfiles.sh data2012
./Download-Indexfiles/download-indexfiles.sh moca2011
./Download-Indexfiles/download-indexfiles.sh moca2012
```

After a successful download, the indexfiles are located in the directory `Indexfiles` where they are classified according to the data sets
and Monte Carlo for 2011 and 2012. The data sets are divided into run periods, the Monte Carlo into processes:

```
ls Indexfiles/*/*
```

4. Build the Docker image `h4leptons` based on the image `cmsopendata/cmssw_5_3_32-slc6_amd64_gcc472`:

```
./build-image.sh
```

Check that the two images have been successfully build:

``` 
docker image ls
```

5. Run the container on the indexfile to be analyzed, e.g.:

```
./run-container.sh data2011/Run2011A_DoubleMu/CMS_Run2011A_DoubleMu_AOD_12Oct2013-v1_10000_file_index.txt
```

6. The output files are located in the directory `Output` where they are classified according to the data sets and Monte Carlo for 2011 and 2012. 
The data sets are divided into run periods, the Monte Carlo into processes:

```
ls Output/*/*
```

7. Have a look at the content of the output file using ROOT:

```
root -l Output/data2011/Run2011A_DoubleMu/CMS_Run2011A_DoubleMu_AOD_12Oct2013-v1_10000.root
root [0] 
Attaching file Output/data2011/Run2011A_DoubleMu/CMS_Run2011A_DoubleMu_AOD_12Oct2013-v1_10000.root as _file0...
(TFile *) 0x7fb6c3e6eb40
root [1] _file0->cd("higgsanalyzer")
(bool) true
root [2] b4_GM_pT->Draw()
Info in <TCanvas::MakeDefCanvas>:  created default TCanvas with name c1
root [3] .q
```

# Instructions to run the analysis using the COMPUTE4PUNCH resources

1. Create the directory `H4leptons`:

```
mkdir $HOME/H4leptons
cd $HOME/H4leptons
```

2. Clone the [gitlab repository](https://gitlab-p4n.aip.de/compute4punch/container-stacks/-/tree/main/h4leptons):

```
git clone https://gitlab-p4n.aip.de/compute4punch/container-stacks.git
```

3. Dowload the indexfiles corresponding to the data sets and Monte Carlo for 2011 and 2012:

```
cd container-stacks/h4leptons
./Download-Indexfiles/download-indexfiles.sh data2011
./Download-Indexfiles/download-indexfiles.sh data2012
./Download-Indexfiles/download-indexfiles.sh moca2011
./Download-Indexfiles/download-indexfiles.sh moca2012
```

After a successful download, the indexfiles are located in the directory `Indexfiles` where they are classified according to the data sets
and Monte Carlo for 2011 and 2012. The data sets are divided into run periods, the Monte Carlo into processes:

```
ls Indexfiles/*/*
```

4. Split the indexfiles into smaller files to have batch jobs of reasonable size:


data 2011:

```
./Split-Indexfiles/split-sample.sh data2011/Run2011A_DoubleElectron 10
./Split-Indexfiles/split-sample.sh data2011/Run2011A_DoubleMu 10
```

data 2012:

```
./Split-Indexfiles/split-sample.sh data2012/Run2012B_DoubleElectron 10
./Split-Indexfiles/split-sample.sh data2012/Run2012B_DoubleMuParked 10
./Split-Indexfiles/split-sample.sh data2012/Run2012C_DoubleElectron 10
./Split-Indexfiles/split-sample.sh data2012/Run2012C_DoubleMuParked 10
```

moca 2011:

```
./Split-Indexfiles/split-sample.sh moca2011/DYJetsToLL_M-10To50 10
./Split-Indexfiles/split-sample.sh moca2011/DYJetsToLL_M-50 10
./Split-Indexfiles/split-sample.sh moca2011/SMHiggsToZZTo4L 5
./Split-Indexfiles/split-sample.sh moca2011/TTTo2L2Nu2B 10
./Split-Indexfiles/split-sample.sh moca2011/ZZTo2e2mu 5
./Split-Indexfiles/split-sample.sh moca2011/ZZTo4e 5
./Split-Indexfiles/split-sample.sh moca2011/ZZTo4mu 5
```

moca 2012:

```
./Split-Indexfiles/split-sample.sh moca2012/DYJetsToLL_M-10to50_HT-200to400 10
./Split-Indexfiles/split-sample.sh moca2012/DYJetsToLL_M-10to50_HT-400toInf 10
./Split-Indexfiles/split-sample.sh moca2012/DYJetsToLL_M-50 10
./Split-Indexfiles/split-sample.sh moca2012/SMHiggsToZZTo4L 5
./Split-Indexfiles/split-sample.sh moca2012/TTTo2L2Nu2B 10
./Split-Indexfiles/split-sample.sh moca2012/ZZTo2e2mu 5
./Split-Indexfiles/split-sample.sh moca2012/ZZTo4e 5
./Split-Indexfiles/split-sample.sh moca2012/ZZTo4mu 5
```

After splitting, the indexfiles are located in the directory `Indexfiles-Splitted`:

```
ls Indexfiles-Splitted/*/*
```

5. Submit the jobs to the HTCondor batch system:

```
cd Submission
```

data 2011:

```
./submit-analysis.sh data2011/Run2011A_DoubleElectron prod
./submit-analysis.sh data2011/Run2011A_DoubleMu prod
```

data 2012:

```
./submit-analysis.sh data2012/Run2012B_DoubleElectron prod
./submit-analysis.sh data2012/Run2012B_DoubleMuParked prod
./submit-analysis.sh data2012/Run2012C_DoubleElectron prod
./submit-analysis.sh data2012/Run2012C_DoubleMuParked prod
```

moca 2011:

```
./submit-analysis.sh moca2011/DYJetsToLL_M-10To50 prod
./submit-analysis.sh moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_1 prod
./submit-analysis.sh moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_2 prod
./submit-analysis.sh moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_3 prod
./submit-analysis.sh moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_4 prod
./submit-analysis.sh moca2011/DYJetsToLL_M-50/DYJetsToLL_M-50_sample_5 prod
./submit-analysis.sh moca2011/SMHiggsToZZTo4L prod
./submit-analysis.sh moca2011/TTTo2L2Nu2B prod
./submit-analysis.sh moca2011/ZZTo2e2mu prod
./submit-analysis.sh moca2011/ZZTo4e prod
./submit-analysis.sh moca2011/ZZTo4mu prod
```
moca 2012:

```
./submit-analysis.sh moca2012/DYJetsToLL_M-10to50_HT-200to400 prod
./submit-analysis.sh moca2012/DYJetsToLL_M-10to50_HT-400toInf prod
./submit-analysis.sh moca2012/DYJetsToLL_M-50 prod
./submit-analysis.sh moca2012/SMHiggsToZZTo4L prod
./submit-analysis.sh moca2012/TTTo2L2Nu2B prod
./submit-analysis.sh moca2012/ZZTo2e2mu prod
./submit-analysis.sh moca2012/ZZTo4e prod
./submit-analysis.sh moca2012/ZZTo4mu prod
```

The production can be followed using the script `test-production.sh` located in the directory `Utils`.
From the directory `Submission` you are located in, do the following commands:

```
cd ..
./Utils/test-production.sh
```

6. The small size of the output files enables to retrieve them locally. This can be done using the script `retrieve-desy-output.sh` 
located in the directory `Utils`. From the directory `h4leptons`you are located in, do the following commands:

```
./Utils/retrieve-desy-output.sh data2011
./Utils/retrieve-desy-output.sh data2012
./Utils/retrieve-desy-output.sh moca2011
./Utils/retrieve-desy-output.sh moca2012
```

After a successful download, the output files are located in the directory `Output`.

7. The different data sets and Monte Carlo samples can now be merged based on the run periods and triggers for the data, and processes for the Monte Carlo.
This can be done using the executable `MergeOutput` located in the directory `Merger`. 
From the directory `h4leptons`, do the following commands:

```
./Merger/MergeOutput data2011
./Merger/MergeOutput data2012
./Merger/MergeOutput moca2011
./Merger/MergeOutput moca2012
```

The merged output files are located in the directory `OutputMerged`.

8. Plot the four leptons invariant mass distribution using the executable `M4Lepton` located in the directory `Plotter`.
From the directory `h4leptons`, do the following command:

```
./Plotter/M4Lepton
```

The plot is saved in the directory `Result`.


# Instructions for the COMPUTE4PUNCH Demonstration

For the demonstration purpose, the analysis is limited to the processing of the Higgs and ZZ Monte Carlo samples.
The data sets and other Monte Carlo samples are already processed and available on the DESY dCache storage.

1. Create the directory `H4leptons`:

```
mkdir $HOME/H4leptons
cd $HOME/H4leptons
```

2. Clone the [gitlab repository](https://gitlab-p4n.aip.de/compute4punch/container-stacks/-/tree/main/h4leptons):

```
git clone https://gitlab-p4n.aip.de/compute4punch/container-stacks.git
```

3. Download the indexfiles corresponding to the Higgs Monte Carlo samples for 2011 and 2012:

```
cd container-stacks/h4leptons
./Download-Indexfiles/download-indexfiles.sh moca2011/SMHiggsToZZTo4L
./Download-Indexfiles/download-indexfiles.sh moca2012/SMHiggsToZZTo4L

./Download-Indexfiles/download-indexfiles.sh moca2011/ZZTo4e
./Download-Indexfiles/download-indexfiles.sh moca2011/ZZTo4mu
./Download-Indexfiles/download-indexfiles.sh moca2011/ZZTo2e2mu

./Download-Indexfiles/download-indexfiles.sh moca2012/ZZTo4e
./Download-Indexfiles/download-indexfiles.sh moca2012/ZZTo4mu
./Download-Indexfiles/download-indexfiles.sh moca2012/ZZTo2e2mu
```

After a successful download, the indexfiles are located in the directory `Indexfiles` where they are classified according to the data sets
and Monte Carlo for 2011 and 2012. The data sets are divided into run periods, the Monte Carlo into processes:

```
ls Indexfiles/*/*
```

4. Split the indexfiles for the Higgs Monte Carlo samples into smaller files to have batch jobs of reasonable size:

```
./Split-Indexfiles/split-sample.sh moca2011/SMHiggsToZZTo4L 5
./Split-Indexfiles/split-sample.sh moca2012/SMHiggsToZZTo4L 5

./Split-Indexfiles/split-sample.sh moca2011/ZZTo2e2mu 5
./Split-Indexfiles/split-sample.sh moca2011/ZZTo4e 5
./Split-Indexfiles/split-sample.sh moca2011/ZZTo4mu 5

./Split-Indexfiles/split-sample.sh moca2012/ZZTo2e2mu 5
./Split-Indexfiles/split-sample.sh moca2012/ZZTo4e 5
./Split-Indexfiles/split-sample.sh moca2012/ZZTo4mu 5
```

After splitting, the indexfiles are located in the directory `Indexfiles-Splitted`:

```
ls Indexfiles-Splitted/*/*
```

5. Submit the jobs to the HTCondor batch system:

```
cd Submission
./submit-analysis.sh moca2011/SMHiggsToZZTo4L prod
```

```
./submit-analysis.sh moca2012/SMHiggsToZZTo4L prod

./submit-analysis.sh moca2011/ZZTo2e2mu prod
./submit-analysis.sh moca2011/ZZTo4e prod
./submit-analysis.sh moca2011/ZZTo4mu prod

./submit-analysis.sh moca2012/ZZTo2e2mu prod
./submit-analysis.sh moca2012/ZZTo4e prod
./submit-analysis.sh moca2012/ZZTo4mu prod
```

The production can be followed using the script `test-production.sh` located in the directory `Utils`.
From the directory `Submission` you are located in, do the following commands:

```
cd ..
./Utils/test-production.sh
```

6. The small size of the output files enables to retrieve them locally. This can be done using the script `retrieve-desy-output.sh`
located in the directory `Utils`. From the directory `h4leptons`you are located in, do the following commands:

```
./Utils/retrieve-desy-output.sh moca2011/SMHiggsToZZTo4L
./Utils/retrieve-desy-output.sh moca2012/SMHiggsToZZTo4L
		     
./Utils/retrieve-desy-output.sh moca2011/ZZTo2e2mu
./Utils/retrieve-desy-output.sh moca2011/ZZTo4e
./Utils/retrieve-desy-output.sh moca2011/ZZTo4mu
		     
./Utils/retrieve-desy-output.sh moca2012/ZZTo2e2mu
./Utils/retrieve-desy-output.sh moca2012/ZZTo4e
./Utils/retrieve-desy-output.sh moca2012/ZZTo4mu
```

After a successful download, the output files are located in the directory `Output`.

7. The different data sets and Monte Carlo samples can now be merged based on the run periods and triggers for the data, and processes for the Monte Carlo.
This can be done using the executable `MergeOutput` located in the directory `Merger`.
From the directory `h4leptons`, do the following commands:

```
./Merger/MergeOutput moca2011/SMHiggsToZZTo4L
./Merger/MergeOutput moca2012/SMHiggsToZZTo4L

./Merger/MergeOutput moca2011/ZZTo2e2mu
./Merger/MergeOutput moca2011/ZZTo4e
./Merger/MergeOutput moca2011/ZZTo4mu

./Merger/MergeOutput moca2012/ZZTo2e2mu
./Merger/MergeOutput moca2012/ZZTo4e
./Merger/MergeOutput moca2012/ZZTo4mu
```

The merged output files are located in the directory `OutputMerged`.

8. Plot the four leptons invariant mass distribution using the executable `M4Lepton` located in the directory `Plotter`.
From the directory `h4leptons`, do the following command:

```
./Plotter/M4Lepton
```

The plot is saved in the directory `Result`.