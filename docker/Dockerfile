FROM ubuntu:jammy

RUN apt-get update && \
  DEBIAN_FRONTEND='noninteractive' \
  DEBCONF_NONINTERACTIVE_SEEN='true' \
  apt-get install --yes \
    gfortran \
    build-essential \
    git \
    python2 \
    mpich \
    curl

RUN useradd \
  --create-home \
  lithomop_user

RUN ln -s /usr/bin/python2 /usr/bin/python;

USER lithomop_user

WORKDIR /home/lithomop_user

RUN git clone 'https://github.com/geodynamics/lithomop.git';

RUN curl -L -O "https://web.cels.anl.gov/projects/petsc/download/release-snapshots/petsc-2.3.3.tar.gz"; tar -xvf petsc-2.3.3.tar.gz; cd petsc-2.3.3-p16;  ./config/configure.py --download-mpich=1 --download-f-blas-lapack=1;

RUN curl -L -O "https://github.com/geodynamics/pythia/releases/download/v0.8.1.20/pythia-0.8.1.20.tar.gz"; tar -xvf pythia-0.8.1.20.tar.gz; cd pythia-0.8.1.20; 

ENV PETSC_DIR=/home/lithomop_user/petsc-2.3.3;