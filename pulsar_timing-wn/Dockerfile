FROM ubuntu:22.04
LABEL maintainer="Joern Kuensemoeller <jkuensem@physik.uni-bielefeld.de>"

# This container contains commonly used software as a basis for pulsar timing workflows.


# environment

ENV TEMPO2 /opt/tempo2/
ENV PSRHOME /opt/psrchive/
ENV PSRCAT_FILE /opt/psrcat/psrcat.db
ENV PGPLOT_DEV /xs

ENV PATH $PATH:/opt/tempo2/bin/
ENV PATH $PATH:/opt/psrchive/bin/
ENV PATH $PATH:/opt/psrcat/bin/

ENV PYTHONPATH $PYTHONPATH:/opt/psrchive/lib/python3.10/site-packages
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/psrchive/lib/

ENV DEBIAN_FRONTEND noninteractive

RUN env


# System and Python packages

RUN apt update
RUN apt -y upgrade


RUN apt install -y htop git python3 python3-dev python3-pip python3-venv language-pack-de language-pack-en && \
    pip install numpy scipy astropy astroplan matplotlib pandas ipython && \
    ln -s /bin/python3 /bin/python 

RUN apt install -y pgplot5 pgplot5 libfftw3-3 libfftw3-dev libfftw3-single3 libfftw3-bin autoconf autogen libtool gfortran tcsh wget libcfitsio-dev swig libhdf5-dev libxml2 libhdf5-dev gsl-bin libgsl-dev pkg-config vim emacs nano htop software-properties-common aptitude libxml2 libxml2-dev python3-tk python3-pyqt5 libxcb-cursor0 && \
    pip install lmfit PyWavelets

RUN add-apt-repository ppa:linuxuprising/libpng12 && \
    apt update && \
    apt install -y libpng12-0 


# Build from source

RUN mkdir /repositories

# Install Tempo2
RUN cd /repositories && \
    git clone https://bitbucket.org/psrsoft/tempo2.git  && \
    cd tempo2  && \
    ./bootstrap  && \
    ./configure --prefix=/opt/tempo2  && \
    make  && \
    make install  && \
    make plugins-install && \
    cp -R T2runtime/* /opt/tempo2/ && \
    cd /repositories && \
    rm -rf tempo2

# Install EPSIC
RUN cd /repositories && git clone https://github.com/straten/epsic.git   && \
    cd epsic  && \
    cd src  && \
    ./bootstrap  && \
    ./configure  && \
    make  && \
    make install  && \
    cd /repositories && \
    rm -rf epsic

# Install PSRchive
RUN cd /repositories && \
    git clone git://git.code.sf.net/p/psrchive/code psrchive  && \
    cd psrchive  && \
    ./bootstrap  && \
    ./configure --prefix=/opt/psrchive --enable-shared  && \
    make  && \
    make install && \
    cd /repositories && \
    rm -rf psrchive

# Some runtime dependencies that rely on an old compiler and are hence not installable as system package 
RUN echo "Downloading gcc-6-base"  && \
    cd /tmp/ && wget http://archive.ubuntu.com/ubuntu/pool/universe/g/gcc-6/gcc-6-base_6.4.0-17ubuntu1_amd64.deb   && \
    echo "Downloading libgfortran3"   && \
    cd /tmp/ && wget http://archive.ubuntu.com/ubuntu/pool/universe/g/gcc-6/libgfortran3_6.4.0-17ubuntu1_amd64.deb  && \
    echo "Installing gcc-6-base"  && \
    cd /tmp/ && dpkg -i gcc-6-base_6.4.0-17ubuntu1_amd64.deb  && \
    echo "Installing libgfortran3"  && \
    cd /tmp/ && dpkg -i libgfortran3_6.4.0-17ubuntu1_amd64.deb  && \
    cd /tmp/ && rm -rf *

# Install PSRcat
RUN apt install -y gcc-9  && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9  && \
    cd /repositories  && \
    wget https://www.atnf.csiro.au/people/pulsar/psrcat/downloads/psrcat_pkg.tar.gz  && \
    tar -xzf psrcat_pkg.tar.gz  && \
    cd psrcat_tar && \
    /bin/bash -c '. makeit'  && \
    mkdir -p /opt/psrcat/bin/ && \
    cp psrcat.db /opt/psrcat/ && \
    cp psrcat /opt/psrcat/bin/ && \
    cd /repositories && \
    rm -rf psrcat_tar && \
    rm psrcat_pkg.tar.gz


RUN rm -rf /repositories



