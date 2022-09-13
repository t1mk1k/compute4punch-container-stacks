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

# Instructions to run the analysis locally

1. Create the directory `H4leptons`:

```
mkdir $HOME/H4leptons
cd $HOME/H4leptons
```

2. Clone the [gitlab repository](https://gitlab-p4n.aip.de/benoit.roland/container-stacks-h4leptons/-/tree/main/h4leptons):

```
git clone https://gitlab-p4n.aip.de/benoit.roland/container-stacks-h4leptons.git
```

3. Dowload the indexfiles corresponding to the data sets and Monte Carlo for 2011 and 2012: 

```
cd container-stacks-h4leptons/h4leptons
./Download-Indexfiles/dowload-data2011.sh
./Download-Indexfiles/dowload-data2012.sh
./Download-Indexfiles/dowload-moca2011.sh
./Download-Indexfiles/dowload-moca2012.sh
```

After a successful download, the indexfiles can be found in the directory `Indexfiles` where they
are classified according to the data sets and Monte Carlo for 2011 and 2012:

```
ls Indexfiles
```

4. Build the Docker image `h4leptons` based on the image `cmsopendata/cmssw_5_3_32-slc6_amd64_gcc472`:

```
./build-image.sh
```

Check that the two images have been successfully build:

``` 
docker image ls
```

5. Run the container on the indexfile to be analyzed, eg:

```
./run-container.sh CMS_Run2011A_DoubleElectron_AOD_12Oct2013-v1_20000_file_index.txt
```

to produce the output file for the indexfile `CMS_Run2011A_DoubleElectron_AOD_12Oct2013-v1_20000_file_index.txt`.

Scripts are available in the directory `Submission` to run locally on all the indexfiles: 


```
./Submission/submit-data2011.sh
./Submission/submit-data2012.sh
./Submission/submit-moca2011.sh
./Submission/submit-moca2012.sh
```

6. The output files can be found in the directory `Output` where they are classified 
according to the data sets and Monte Carlo for 2011 and 2012:

```
ls Output
```

7. Once all the data sets and Monte Carlo files have been processed and the ouput retrieved in the directory `Output`, merge the samples with the script `MergeOutput.sh`:

```
./Merger/MergeOutput.sh data2011
./Merger/MergeOutput.sh data2012
./Merger/MergeOutput.sh moca2011
./Merger/MergeOutput.sh moca2012
```

The merged output files can be found in the directory `OutputMerged`.

8. Plot the four leptons invariant mass distribution:

```
root -l Plotter/M4Lepton.cc
```

The plot is saved in the directory `Result`.

```
ls Result
```
