FROM ubuntu:16.04 as base

# Installing dependecies
RUN apt-get update -y
RUN apt-get install -y python build-essential git wget
RUN apt-get install -y gcc g++ gfortran
RUN apt-get update -y

# Installing OpenMPI 3.1.3
RUN mkdir -p /var/tmp/ompi
WORKDIR "/var/tmp/ompi"
RUN wget -q -nc --no-check-certificate -P /var/tmp/ompi https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-3.1.3.tar.bz2
RUN tar -xvf openmpi-3.1.3.tar.bz2

WORKDIR "/var/tmp/ompi/openmpi-3.1.3"
RUN ./configure --prefix=/usr/local
RUN make
RUN make install

WORKDIR "/"
RUN rm -rf /var/tmp/ompi

# Setting the environmental parameters
ENV LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
ENV PATH="/usr/local/bin:$PATH"

# Downloading the tests
WORKDIR "/var/tmp"

RUN wget -q -nc --no-check-certificate -P /var/tmp https://raw.githubusercontent.com/tomaslaz/handybox/master/MPI/Performance/point_to_point_mpi_send.c
RUN mpicc -o /usr/local/bin/point_to_point_mpi_send /var/tmp/point_to_point_mpi_send.c

RUN wget -q -nc --no-check-certificate -P /var/tmp https://raw.githubusercontent.com/open-mpi/ompi/master/examples/ring_c.c
RUN mpicc -o /usr/local/bin/ring_c /var/tmp/ring_c.c

RUN rm -rf /var/tmp/ring_c.c /var/tmp/point_to_point_mpi_send.c

# Execute the ring example
CMD ["mpirun", "-np", "2", "--allow-run-as-root", "/usr/local/bin/ring_c"]
