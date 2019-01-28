# Host Ubuntu 18 **OpenMPI 3.1.3**

### Client Ubuntu 18 / OpenMPI 3.1.3 (Simple example works)
  ```
  mpirun -n 2 singularity exec mpi3_test.simg /usr/local/bin/point_tpoint_mpi_send
  ```
### Client Ubuntu 16 / OpenMPI 3.1.3 (Doesn't work)

  ```
  mpirun -n 2 singularity exec mpi3_test.simg /usr/local/bin/point_tpoint_mpi_send
  ```

  Hangs - we need to understand why...

# Host Ubuntu 16 **OpenMPI 3.1.3**

## Client Ubuntu 16 / OpenMPI 2.1.6 (Did not work)

  ```
  mpirun -n 2 singularity exec mpi2_test.simg /usr/local/bin/point_to_point_mpi_send
  ```

  The errors:

  ```
  --------------------------------------------------------------------------
  It looks like MPI_INIT failed for some reason; your parallel process is
  likely to abort.  There are many reasons that a parallel process can
  fail during MPI_INIT; some of which are due to configuration or environment
  problems.  This failure appears to be an internal failure; here's some
  additional information (which may only be relevant to an Open MPI
  developer):

    ompi_mpi_init: ompi_rte_init failed
    --> Returned "(null)" (-43) instead of "Success" (0)
  --------------------------------------------------------------------------
  [tomas-VirtualBox:28400] *** An error occurred in MPI_Init
  [tomas-VirtualBox:28400] *** on a NULL communicator
  [tomas-VirtualBox:28400] *** MPI_ERRORS_ARE_FATAL (processes in this communicator will now abort,
  [tomas-VirtualBox:28400] ***    and potentially your MPI job)
  [tomas-VirtualBox:28400] Local abort before MPI_INIT completed completed successfully, but am not able to aggregate error messages, and not able to guarantee that all other processes were killed!
  --------------------------------------------------------------------------
  It looks like MPI_INIT failed for some reason; your parallel process is
  likely to abort.  There are many reasons that a parallel process can
  fail during MPI_INIT; some of which are due to configuration or environment
  problems.  This failure appears to be an internal failure; here's some
  additional information (which may only be relevant to an Open MPI
  developer):

    ompi_mpi_init: ompi_rte_init failed
    --> Returned "(null)" (-43) instead of "Success" (0)
  --------------------------------------------------------------------------
  [tomas-VirtualBox:28401] *** An error occurred in MPI_Init
  [tomas-VirtualBox:28401] *** on a NULL communicator
  [tomas-VirtualBox:28401] *** MPI_ERRORS_ARE_FATAL (processes in this communicator will now abort,
  [tomas-VirtualBox:28401] ***    and potentially your MPI job)
  [tomas-VirtualBox:28401] Local abort before MPI_INIT completed completed successfully, but am not able to aggregate error messages, and not able to guarantee that all other processes were killed!
  --------------------------------------------------------------------------
  Primary job  terminated normally, but 1 process returned
  a non-zero exit code. Per user-direction, the job has been aborted.
  --------------------------------------------------------------------------
  --------------------------------------------------------------------------
  mpirun detected that one or more processes exited with non-zero status, thus causing
  the job to be terminated. The first process to do so was:

    Process name: [[64448,1],0]
    Exit code:    1
  --------------------------------------------------------------------------

  ```

## Client Ubuntu 16 / OpenMPI 3.1.3 (Simple example works)

  ```
  mpirun -n 2 singularity exec mpi3_test.simg /usr/local/bin/point_tpoint_mpi_send
  ```

## Client Ubuntu 16 / OpenMPI 4.0.0 (Simple example works)

  ```
  mpirun -n 2 singularity exec mpi4_test.simg /usr/local/bin/point_to_point_mpi_send
  ```
