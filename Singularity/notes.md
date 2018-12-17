## Building a simple NVIDIA multi-gpu example


### Building containers from Singularity definition files

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

### Downloading an existing container from Docker Hub

```
sudo singularity build multigpu.simg library://library/default/ubuntu:16.04
```

This prepares a base for the container -- ubuntu:16.04
