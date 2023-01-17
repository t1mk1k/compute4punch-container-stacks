# syntax=docker/dockerfile:1

#Use kernsuite image as it contains python-casacore and chgcentre
FROM kernsuite/base:7

#Create a new user so that everything is not run as root
RUN groupadd -g 1024 player1 && useradd -u 1024 player1 -g player1

#Create home directory for that user
RUN mkhomedir_helper player1

#Install python-casacore
RUN docker-apt-install python3-casacore

#Install chgcentre
RUN docker-apt-install chgcentre

#Update apt-get and install useful packages: python-is-python3 to symlink python command to python3 command, git, wget, xz-utils, pip3
RUN apt-get update && apt-get -y install wget xz-utils git pip python-is-python3

#Install snakemake via pip
RUN pip3 install snakemake==7.19.1 pyyaml astropy>=5.0

#Change user to "user"
USER player1

#Change working directory
WORKDIR /home/player1

#Update environmental variable
ENV PATH="$PATH:/home/player1/.local/bin"

#Download CASA tarball
RUN wget https://casa.nrao.edu/download/distro/casa/release/rhel/casa-6.5.2-26-py3.8.tar.xz

#Extract in home directory
RUN tar -xvf casa-6.5.2-26-py3.8.tar.xz

#Remove the .tar.xz file, not needed
RUN rm casa-6.5.2-26-py3.8.tar.xz

#Git clone arcane suite
RUN git clone -b PUNCH_dim_test https://github.com/rstofi/arcane_suite.git

#Change folder to the arcane_suite
WORKDIR /home/player1/arcane_suite

#Install the arcane arcane_suite
RUN pip install -e ./

#Create directory where the workflow will operate
RUN mkdir /home/player1/workflowdir

#Return to home directory, this will be the volume
WORKDIR /home/player1/workflowdir
