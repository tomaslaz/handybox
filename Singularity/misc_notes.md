### MPI

Another result of the Singularity architecture is the ability to properly integrate with the Message Passing Interface (MPI). Work has already been done for out of the box compatibility with Open MPI (both in Open MPI v2.1.x as well as part of Singularity). The Open MPI/Singularity workflow works as follows:

- mpirun is called by the resource manager or the user directly from a shell
- Open MPI then calls the process management daemon (ORTED)
- The ORTED process launches the Singularity container requested by the mpirun command
- Singularity builds the container and namespace environment
- Singularity then launches the MPI application within the container
- The MPI application launches and loads the Open MPI libraries
- The Open MPI libraries connect back to the ORTED process via the Process Management Interface (PMI)
- At this point the processes within the container run as they would normally directly on the host.


#### MPI versions

https://github.com/sylabs/singularity/issues/165
```
you can use newer on the host, but not newer in the container
```
**Not true** - check the OpenMPI_Example Notes.md

#### Why do we call ‘mpirun’ from outside the container (rather then inside)?

With Singularity, the MPI usage model is to call ‘mpirun’ from outside the container, and reference the container from your ‘mpirun’ command. Usage would look like this:

$ mpirun -np 20 singularity exec container.img /path/to/contained_mpi_prog
By calling ‘mpirun’ outside the container, we solve several very complicated work-flow aspects. For example, if ‘mpirun’ is called from within the container it must have a method for spawning processes on remote nodes. Historically ssh is used for this which means that there must be an sshd running within the container on the remote nodes, and this sshd process must not conflict with the sshd running on that host! It is also possible for the resource manager to launch the job and (in Open MPI’s case) the Orted processes on the remote system, but that then requires resource manager modification and container awareness.

# Using SINGULARITY 2.6 (not tested with v. > 2.6)

### User files in the container by the default should be kept in:
```/usr/local/``` ```/usr/bin/```

### Singularity by default binds the following paths from the host system:

```$HOME /tmp /proc /sys /dev $PWD```

### It is good practice to set up following enviroment parameters

```
export NV_GPU=$CUDA_VISIBLE_DEVICES
export SINGULARITYENV_CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES

export SINGULARITY_CACHEDIR=/tmp
```

### ```No space left on device``` issue can be solved using

```
export SINGULARITY_CACHEDIR=/tmp
```

and making sure that the "/tmp" is bound:

```
singularity exec ... -B /tmp ...
```

### General usage (based on v.3)

#### Building containers from Singularity definition files

```
Bootstrap: docker
From: nvcr.io/nvidia/cuda:9.0-devel-ubuntu16.04
```

- *Bootstrap*: references the kind of base you want to use
- *From*: is the named container (shub) or reference to layers (Docker) that you want to use


<!-- %post
    apt-get -y update
    apt-get -y install fortune cowsay lolcat

%environment
    export LC_ALL=C
    export PATH=/usr/games:$PATH

%runscript
    fortune | cowsay | lolcat -->

#### Build the image

sudo singularity build multigpu.sif multigpu.def

#### Downloading an existing container from Docker Hub

```
sudo singularity build multigpu.simg library://library/default/ubuntu:16.04
```

This prepares a base for the container -- ubuntu:16.04

#### production build
For a production build we need to remove -s (--sandbox) tag in order to build a compressed read-only Singularity Image File (SIF).

```
sudo singularity build ubuntu_mpi.sif ubuntu_mpi.def
```
