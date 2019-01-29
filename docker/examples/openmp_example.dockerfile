FROM ubuntu:16.04 as base

# Installing dependecies
RUN apt-get update -y
RUN apt-get install -y python build-essential git wget
RUN apt-get install -y gcc g++ gfortran
RUN apt-get update -y

# Downloading the test
WORKDIR "/opt"
RUN git clone https://github.com/LangdalP/EPCC-OpenMP-micro-benchmarks.git
WORKDIR "/opt/EPCC-OpenMP-micro-benchmarks/"
RUN mv Makefile.defs Makefile.defs_backup; mv Makefile.defs.gcc Makefile.defs
RUN make
WORKDIR "/"

# Setting up environmental parameters
ENV OMP_NUM_THREADS=4

# Execute the example
CMD ["/opt/EPCC-OpenMP-micro-benchmarks/bin/taskbench"]
