It is necessary to add on the prefix the installation directory we want to use for OpenMPI.

Configuring to use GCC-8 compilers (if multiple compilers are installed):

```./configure CC=gcc-8 CXX=g++-8 F77=gfortran-8 FC=gfortran-8 --prefix=/usr/local```

Time to install:

```
make
sudo make install
```

Including the path to our path environment and the path and to the library environment variable

```
export PATH="/usr/local/bin$PATH"
export LD_LIBRARY_PATH="/usr/local/lib/:$LD_LIBRARY_PATH"
```

For effectiveness adding the exports in the environment variable's file ~/.bash_profile.
