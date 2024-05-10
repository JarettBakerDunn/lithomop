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

RUN curl -L -O "https://ftp.mcs.anl.gov/pub/petsc/externalpackages/f2cblaslapack-3.8.0.q2.tar.gz"; tar -xvf f2cblaslapack-3.8.0.q2.tar.gz;

RUN curl -L -O "https://web.cels.anl.gov/projects/petsc/download/release-snapshots/petsc-2.3.3.tar.gz"; tar -xvf petsc-2.3.3.tar.gz; cd petsc-2.3.3-p16;

RUN curl -L -O "https://github.com/geodynamics/pythia/releases/download/v0.8.1.20/pythia-0.8.1.20.tar.gz"; tar -xvf pythia-0.8.1.20.tar.gz; cd pythia-0.8.1.20; 

RUN git clone 'https://github.com/geodynamics/lithomop.git'; cd lithomop;

ENV PETSC_DIR=/home/lithomop_user/petsc-2.3.3-p16