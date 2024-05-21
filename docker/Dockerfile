FROM ubuntu:jammy

RUN apt-get update && \
  DEBIAN_FRONTEND='noninteractive' \
  DEBCONF_NONINTERACTIVE_SEEN='true' \
  apt-get install --yes \
    gfortran \
    build-essential \
    git \
    python2 \
    python3 \
    python2-dev \
    mpich \
    curl \
    libblas-dev \
    liblapack-dev \
    autoconf \
    automake \
    autoconf-archive

RUN useradd \
  --create-home \
  lithomop_user

RUN ln -s /usr/bin/python2 /usr/bin/python;

USER lithomop_user

WORKDIR /home/lithomop_user

ENV PETSC_DIR=/home/lithomop_user/petsc-2.3.3-p16

RUN curl -L -O "https://web.cels.anl.gov/projects/petsc/download/release-snapshots/petsc-2.3.3.tar.gz"; tar -xvf petsc-2.3.3.tar.gz; cd petsc-2.3.3-p16; ./config/configure.py; make all;

ENV PATH=$PETSC_DIR/externalpackages/mpich2-1.0.3/linux-gnu-c-real-debug/bin:$PATH

RUN git clone "https://github.com/geodynamics/pythia.git"; cd pythia; autoupdate; mkdir aux-config;

RUN git clone 'https://github.com/geodynamics/lithomop.git';

