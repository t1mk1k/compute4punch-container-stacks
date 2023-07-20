# syntax=docker/dockerfile:1

#Start from python image
FROM python:3.8.16-slim-bullseye

#Update apt-get and install useful packages: build-essential for caracal, the rest for singularity 
RUN apt-get update && apt-get -y install build-essential manpages-dev build-essential uuid-dev libgpgme-dev squashfs-tools libseccomp-dev wget pkg-config git cryptsetup-bin xz-utils

#Clean cache
RUN apt-get clean

#Install Go
ENV VERSION=1.20.3 OS=linux ARCH=amd64
RUN wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz
RUN tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz
RUN rm go$VERSION.$OS-$ARCH.tar.gz

#Setup environment for Go
ENV GOPATH=${HOME}/go PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin

#Download singularity
ENV VERSION=3.8.1
RUN wget https://github.com/hpcng/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz
RUN tar -xzf singularity-${VERSION}.tar.gz
RUN rm singularity-${VERSION}.tar.gz
WORKDIR /singularity-${VERSION}

#Install singularity
RUN ./mconfig --without-suid 
RUN make -C ./builddir
RUN make -C ./builddir install

#Install requirements
RUN pip install --no-cache-dir -U pip setuptools wheel

#Install caracal
RUN pip install --no-cache-dir -U caracal==1.0.6

#Force re-install of stimela
RUN pip install --no-cache-dir -U --force-reinstall git+https://github.com/ratt-ru/Stimela.git