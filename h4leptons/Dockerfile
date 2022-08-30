FROM cmsopendata/cmssw_5_3_32-slc6_amd64_gcc472:latest

LABEL maintainer="Benoit Roland <benoit.roland@kit.edu>"

USER root

RUN yum install -y emacs

ENV WORKDIR /home/cmsusr/CMSSW_5_3_32/src

ENV ANALYSIS /home/cmsusr/CMSSW_5_3_32/src/HiggsAnalysis

COPY HiggsAnalysis $WORKDIR/HiggsAnalysis

RUN chmod +x $ANALYSIS/make-analyzer-cfg.sh

RUN chmod +x $ANALYSIS/analysis.sh 

RUN mkdir -p $WORKDIR/Output


