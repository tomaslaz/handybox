# Using SINGULARITY 2.6

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
