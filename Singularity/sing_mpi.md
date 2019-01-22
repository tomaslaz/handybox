# Singularity MPI support

Initial test by performing point to point (MPI_SEND/MPI_RECV) benchmarking show on average 3x lower MB/s transfer between standard mpirun and mpirun within a container using %runscript

It needs to be tested if this not the case that when executing Singularity

```
singularity
```
