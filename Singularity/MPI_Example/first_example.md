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



https://github.com/sylabs/singularity/issues/165


sbatch ...
srun --mpi=pmi2 -n16 singularity exec c7.img run.it > out_now


as I understand, you can use newer on the host, but not newer in the container


https://www.nsc.liu.se/support/singularity/mpi/

https://www.sylabs.io/guides/2.6/admin-guide/installation_environments.html

Another result of the Singularity architecture is the ability to properly integrate with the Message Passing Interface (MPI). Work has already been done for out of the box compatibility with Open MPI (both in Open MPI v2.1.x as well as part of Singularity). The Open MPI/Singularity workflow works as follows:

mpirun is called by the resource manager or the user directly from a shell
Open MPI then calls the process management daemon (ORTED)
The ORTED process launches the Singularity container requested by the mpirun command
Singularity builds the container and namespace environment
Singularity then launches the MPI application within the container
The MPI application launches and loads the Open MPI libraries
The Open MPI libraries connect back to the ORTED process via the Process Management Interface (PMI)
At this point the processes within the container run as they would normally directly on the host.



##############################

Why do we call ‘mpirun’ from outside the container (rather then inside)?
With Singularity, the MPI usage model is to call ‘mpirun’ from outside the container, and reference the container from your ‘mpirun’ command. Usage would look like this:

$ mpirun -np 20 singularity exec container.img /path/to/contained_mpi_prog
By calling ‘mpirun’ outside the container, we solve several very complicated work-flow aspects. For example, if ‘mpirun’ is called from within the container it must have a method for spawning processes on remote nodes. Historically ssh is used for this which means that there must be an sshd running within the container on the remote nodes, and this sshd process must not conflict with the sshd running on that host! It is also possible for the resource manager to launch the job and (in Open MPI’s case) the Orted processes on the remote system, but that then requires resource manager modification and container awareness.

In the end, we do not gain anything by calling ‘mpirun’ from within the container except for increasing the complexity levels and possibly loosing out on some added performance benefits (e.g. if a container wasn’t built with the proper OFED as the host).

See the Singularity on HPC page for more details.

Does Singularity support containers that require GPUs?
Yes, Singularity has been tested to run some test and diagnostic code from within a container without modification. There are however potential issues that can come into play when using GPUs, for instance there are version API compatibilities between kernel and user land which will have to be considered.


$ mpirun -np 20 singularity exec container.img /path/to/contained_mpi_prog
