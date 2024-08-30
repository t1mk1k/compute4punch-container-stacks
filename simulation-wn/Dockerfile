# Download base image ubuntu 22.04
FROM ubuntu:22.04


# Install davix:
RUN apt-get -y update && \
    apt-get -y install pip && \
    apt-get -y install git &&\
    python3 -m pip install --upgrade pip &&\
    python3 -m pip install yt==4.3.1 && \
    python3 -m pip install h5py==3.11.0 &&\
    python3 -m pip install matplotlib==3.9 &&\
    python3 -m pip install scipy==1.14.1 &&\
    python3 -m pip install wheel &&\
    apt-get -y install curl &&\
    apt-get -y install davix &&\
    python3 -m pip install git+https://github.com/cern-fts/gfal2-util.git@v1.9.0