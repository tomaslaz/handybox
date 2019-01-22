First we use a singularity definition file

```
sudo singularity build -s ubuntu_mpi.sif ubuntu_mpi.def
```


To develop the image we can shell into it. We need sudo it in order to get access to all the files and directories

```
sudo singularity shell --writable ubuntu_mpi.sif
```

```
singularity exec ubuntu_mpi.sif mpirun --allow-run-as-root -n 4 /usr/local/bin/benchmarking/handybox/MPI/Performance/point_to_point_mpi_send
```

singularity run ubuntu_mpi.sif


For a production build we need to remove -s (--sandbox) tag in order to build a compressed read-only Singularity Image File (SIF).

```
sudo singularity build ubuntu_mpi.sif ubuntu_mpi.def
```
