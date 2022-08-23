FROM debian:bullseye as builder

ARG SRC=/usr/local/src
ARG J=16
ARG DEBIAN_FRONTEND=noninteractive

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/:/usr/local/idg/lib/

RUN apt-get update && \
    apt-get install -y emacs htop nano mc \
    git \
    wget \
    rsync \
    python3-pip \
    libfftw3-dev \
    python3-numpy \
    libfreetype6-dev \
    libpng-dev \
    pkg-config \
    python3-dev \
    libboost-all-dev \
    libcfitsio-dev \
    wcslib-dev \
    libatlas-base-dev \
    liblapack-dev \
    python3-tk \
    libreadline6-dev \
    liblog4cplus-dev \
    libhdf5-dev \
    libncurses5-dev \
    libssl-dev \
    flex \
    bison \
    libbison-dev \
    python3-matplotlib \
    python3-numexpr \
    python3-astropy \
    python3-cpuinfo \
    python3-future \
    python3-lxml \
    python3-pandas \
    python3-psutil \
    python3-pyfftw python3-pymysql python3-scipy \
    python3-requests python3-deap \
    python3-sshtunnel \
    python3-ruamel.yaml python3-ephem \
    ipython3 \
    libgsl-dev \
    libgtkmm-3.0-dev \
    libcfitsio-bin libxml2-dev libarmadillo-dev libsigc++-2.0-dev liblua5.3-dev && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1 && \
    apt-get install -y casacore-dev casacore-tools python3-casacore cmake curl && \
    apt-get install -y python3-astlib python3-ipdb python3-nose python3-metaconfig jq util-linux bsdmainutils

RUN pip3 install pybind11 && \
    pip3 install dask codex_africanus ephem Polygon3 pyregion terminal pyephem ptyprocess timeout-decorator astroquery && \
    pip3 install --ignore-installed numpy==1.19.5 && \
    pip3 install reproject

RUN pip3 install git+https://github.com/lofar-astron/PyBDSF.git

RUN cd $SRC && \
    git clone -b v4.1.1 https://github.com/lofar-astron/LOFARBeam.git && \
    cd LOFARBeam && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j $J && \
    make install

RUN cd /usr/local/lib/python3.9/dist-packages && \
    ln -s /usr/local/lib/python3.9/site-packages/lofar

RUN cd $SRC && \
    git clone https://github.com/aroffringa/dysco.git && \
    cd dysco && \
    git checkout 3fd7a5fd17f3d09db89ad7827c9bdc4febf66eff && \
    mkdir build && \
    cd build && \
    cmake ../ && \
    make -j $J && \
    make install && \
    cp $SRC/dysco/build/decompress /usr/local/bin/decompress 

RUN cd $SRC && \
    git clone -b v3.1.0 https://gitlab.com/aroffringa/aoflagger.git && \
    cd aoflagger  && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j $J && \
    make install

RUN cd $SRC && \
    git clone -b v0.1.3 https://git.astron.nl/RD/EveryBeam.git && \
    cd EveryBeam && \
    mkdir build && \
    cd build && \
    cmake -DBUILD_WITH_PYTHON=On .. && \
    make -j $J && \
    make install


RUN cd $SRC && \
    git clone -b v5.1 https://github.com/lofar-astron/DP3.git && \
    cd DP3 && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_PREFIX_PATH=/usr/local/idg && \
    make -j $J && \
    make install

RUN pip3 install -U tables prettytable pylru emcee astropy_healpix sharedarray

RUN pip3 install losoto

RUN pip3 install pyavm && \
    pip3 install imageio==2.14.1 && \
    pip3 install aplpy

RUN cd $SRC && \
    git clone -b v3.0 https://gitlab.com/aroffringa/wsclean.git && \
    cd wsclean && \
    mkdir -p build && \
    cd build && \
    cmake .. -DCMAKE_PREFIX_PATH=/usr/local/idg && \
    make -j $J && \
    make install

RUN cd $SRC && \
    git clone -b v0.6.0 https://github.com/saopicc/DDFacet.git && \
    cd DDFacet && \
    python setup.py install

RUN cd $SRC && \
    git clone -b v3.0.1 https://github.com/saopicc/killMS.git && \
    cd killMS && \
    python setup.py install

RUN cd $SRC && \
    git clone https://github.com/cyriltasse/DynSpecMS.git

RUN cd $SRC && \
    git clone https://github.com/mhardcastle/lotss-query.git

RUN cd $SRC && \
    git clone https://github.com/mhardcastle/lotss-hba-survey.git

RUN cd $SRC && \
    git clone https://github.com/mhardcastle/ddf-pipeline.git  && \
    ddf-pipeline/scripts/install.sh

RUN cd /usr/local/src && \
    wget https://rclone.org/install.sh && \
    bash install.sh

RUN cd /usr/local/src && \
    git clone https://github.com/sara-nl/SpiderScripts.git && \
    cd SpiderScripts && \
    cp ada/ada /usr/local/bin

RUN pip3 list --format=columns

RUN pip3 cache purge && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN bash -c "rm -rf /usr/local/src/{DP3,EveryBeam,LOFARBeam,aoflagger,dysco,idg,wsclean,PyBDSF,SpiderScripts}/" && \
    ln -s /usr/local/bin/DPPP /usr/local/bin/DP3
