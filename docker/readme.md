TESTING: checkLib from config.packages.BlasLapack(python/BuildSystem/config/packages/BlasLapack.py:94)                                                                                    *********************************************************************************
         UNABLE to CONFIGURE with GIVEN OPTIONS    (see configure.log for details):
---------------------------------------------------------------------------------------
Could not find a functional BLAS. Run with --with-blas-lib=<lib> to indicate the library containing BLAS.
 Or --download-f-blas-lapack=1 to have one automatically downloaded and installed

 --with-blas-lib=/home/lithomop_user/fblaslapack

 https://ftp.mcs.anl.gov/pub/petsc/externalpackages/


 RUN curl -L -O "https://ftp.mcs.anl.gov/pub/petsc/externalpackages/f2cblaslapack-3.8.0.q2.tar.gz"; tar -xvf f2cblaslapack-3.8.0.q2.tar.gz;


 autoupdate
 mkdir aux-config
 autoreconf
 automake --add-missing
 autoreconf
 ./configure PYTHONPATH=/usr/local/lib/python2.7/dist-packages
 make
 make install


when trying configure on lithomop, it now seems petsc is the problem: ./configure: line 3715: `CIT_PATH_PETSC(2.3.3)'
petsc

put in the directory /home/lithomop_user/petsc-2.3.3-p16/externalpackages the uncompressed, untared file obtained
need to put mpich in the petsc/externalpackages folder. needs to be : ftp://ftp.mcs.anl.gov/pub/petsc/externalpackages/mpich2-1.0.5p4.tar.gz

curl -L -O https://ftp.mcs.anl.gov/pub/petsc/externalpackages/mpich2-1.0.5p4.tar.gz

looks like you need to configure and install mpi after downloaded and 

need to use -prefix= for the directory where to install mpi. I guess we install it where we download it?

this might be needed to configure mpich: ./config/configure.py --with-mpi-dir=/home/lithomop_user/petsc-2.3.3-p16/externalpackages/mpich2-1.0.3


ran ./configure and make in mpich before running ./config/configure.py --with-mpi-dir=/home/lithomop_user/petsc-2.3.1-p19/externalpackages/mpich2-1.0.3. 
allowed me to actual configure petsc. Seemed to work.

---------------------------
trying to build with setuptoolz results in this:

Downloading http://pypi.python.org/packages/source/d/distribute/distribute-0.6.14.tar.gz
Traceback (most recent call last):
  File "setup.py", line 2, in <module>
    use_setuptools()
  File "/home/lithomop_user/.local/lib/python2.7/site-packages/ez_setup.py", line 145, in use_setuptools
    return _do_download(version, download_base, to_dir, download_delay)
  File "/home/lithomop_user/.local/lib/python2.7/site-packages/ez_setup.py", line 124, in _do_download
    to_dir, download_delay)
  File "/home/lithomop_user/.local/lib/python2.7/site-packages/ez_setup.py", line 193, in download_setuptools
    src = urlopen(url)
  File "/usr/lib/python2.7/urllib2.py", line 154, in urlopen
    return opener.open(url, data, timeout)
  File "/usr/lib/python2.7/urllib2.py", line 435, in open
    response = meth(req, response)
  File "/usr/lib/python2.7/urllib2.py", line 548, in http_response
    'http', request, response, code, msg, hdrs)
  File "/usr/lib/python2.7/urllib2.py", line 473, in error
    return self._call_chain(*args)
  File "/usr/lib/python2.7/urllib2.py", line 407, in _call_chain
    result = func(*args)
  File "/usr/lib/python2.7/urllib2.py", line 556, in http_error_default
    raise HTTPError(req.get_full_url(), code, msg, hdrs, fp)
urllib2.HTTPError: HTTP Error 403: SSL is required

needs to be https. Do I edit the setup file?? Using nano to edit setup file seems to have worked. Now getting new error:
configure: error: cannot scan Python eggs for flags
------
LOG:

configure:4289: checking for egg-related flags
configure:4292: /usr/bin/python setup.py egg_flags >&5 2>&5
usage: setup.py [global_opts] cmd1 [cmd1_opts] [cmd2 [cmd2_opts] ...]
   or: setup.py --help [cmd1 cmd2 ...]
   or: setup.py --help-commands
   or: setup.py cmd --help

error: invalid command 'egg_flags'
configure:4295: $? = 1
configure:4304: result: failed
configure:4306: error: in `/home/lithomop_user/lithomop':
configure:4308: error: cannot scan Python eggs for flags
---------