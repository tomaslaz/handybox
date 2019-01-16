FROM ubuntu:16.04 as base

# Installing git
RUN apt-get update
RUN apt-get -y install git

# Installing MPI
RUN apt-get update
RUN apt-get install libcr-dev mpich2 mpich2-doc
