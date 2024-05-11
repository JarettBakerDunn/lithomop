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
    curl \
    libblas-dev \
    liblapack-dev

RUN useradd \
  --create-home \
  lithomop_user

RUN ln -s /usr/bin/python2 /usr/bin/python;

USER lithomop_user

WORKDIR /home/lithomop_user

ENV PETSC_DIR=/home/lithomop_user/petsc-2.3.3-p16

RUN curl -L -O "https://web.cels.anl.gov/projects/petsc/download/release-snapshots/petsc-2.3.3.tar.gz"; tar -xvf petsc-2.3.3.tar.gz; cd petsc-2.3.3-p16; ./config/configure.py; make all;

ENV PATH=$PETSC_DIR/externalpackages/mpich2-1.0.3/linux-gnu-c-real-debug/bin:$PATH

RUN curl -L -O "https://github.com/geodynamics/pythia/releases/download/v0.8.1.16/pythia-0.8.1.16.tar.gz"; tar -xvf pythia-0.8.1.16.tar.gz; 
RUN cd pythia-0.8.1.16; curl -L -O "http://pypi.python.org/packages/2.7/s/setuptools/setuptools-0.6c11-py2.7.egg"; python setup.py

RUN git clone 'https://github.com/geodynamics/lithomop.git'; cd lithomop;

