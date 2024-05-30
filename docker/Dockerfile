FROM ubuntu:jammy

RUN apt-get update && \
  DEBIAN_FRONTEND='noninteractive' \
  DEBCONF_NONINTERACTIVE_SEEN='true' \
  apt-get install --yes \
    gfortran \
    build-essential \
    git \
    mpich \
    curl \
    libblas-dev \
    liblapack-dev \
    autoconf \
    automake \
    autoconf-archive \
    python2 \
    libtool

RUN useradd \
  --create-home \
  lithomop_user

# Installing python 2.3 in order to match the instructions from ./INSTALL
#RUN curl -L -O "https://www.python.org/ftp/python/2.3/Python-2.3.tgz"; tar -zxvf Python-2.3.tgz; cd Python-2.3; ./configure BASECFLAGS=-U_FORTIFY_SOURCE; make; make install;

# Need to create this link so that pythia will compile
RUN ln -s /usr/bin/python2 /usr/bin/python;

WORKDIR /home/lithomop_user

USER lithomop_user

ENV PETSC_DIR=/home/lithomop_user/petsc-2.3.3-p16

RUN curl -L -O "https://web.cels.anl.gov/projects/petsc/download/release-snapshots/petsc-2.3.3.tar.gz"; tar -xvf petsc-2.3.3.tar.gz; cd petsc-2.3.3-p16; ./config/configure.py; make all;

ENV PATH=$PETSC_DIR/externalpackages/mpich2-1.0.3/linux-gnu-c-real-debug/bin:$PATH

USER root

RUN curl -L -O "https://github.com/geodynamics/pythia/releases/download/v0.8.1.16/pythia-0.8.1.16.tar.gz"; tar -xvf pythia-0.8.1.16.tar.gz; cd pythia-0.8.1.16; curl -L -O "https://pypi.python.org/packages/2.7/s/setuptools/setuptools-0.6c11-py2.7.egg"; python2 setup.py build; python2 setup.py build install;

USER lithomop_user

RUN git clone --recurse-submodules 'https://github.com/jarettbakerdunn/lithomop.git'; cd lithomop; git checkout devel; git fetch; git pull; mkdir aux-config; autoreconf -i;
#autoreconf; mkdir aux-config; autoreconf; automake --add-missing; exit 0;