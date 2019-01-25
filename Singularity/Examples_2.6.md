# GPU

## 1. Downloading and executing NVIDIA docker container on 1/2/4 GPUs

- Let's create an image:
```
sudo singularity build nvidia_test.simg docker://nvidia/cuda:9.0-devel-ubuntu16.04
```
- Copy the image to the HPC machine

- Submit a job using a job submission file
  - JADE
    - Job submission file on **1 GPU**

```
#!/bin/bash

# set the number of nodes
#SBATCH --nodes=1

# set max wallclock time
#SBATCH --time=0:01:00

# set name of job
#SBATCH --job-name=nvidia_test

# set number of GPUs
#SBATCH --gres=gpu:1

# mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

# send mail to this address
#SBATCH --mail-user=

# queue
#SBATCH --partition=small

module load singularity
export NV_GPU=$CUDA_VISIBLE_DEVICES
export SINGULARITYENV_CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES

# run the application
singularity exec --nv nvidia_test.simg nvidia-smi; echo $CUDA_VISIBLE_DEVICES
```

- Copy the image to the HPC machine
  - JADE
    - Job submission file on **4 GPUs**

```

#!/bin/bash

# set the number of nodes
#SBATCH --nodes=1

# set max wallclock time
#SBATCH --time=0:01:00

# set name of job
#SBATCH --job-name=nvidia_test

# set number of GPUs
#SBATCH --gres=gpu:4

# mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

# send mail to this address
#SBATCH --mail-user=

# queue
#SBATCH --partition=big

module load singularity
export NV_GPU=$CUDA_VISIBLE_DEVICES
export SINGULARITYENV_CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICE

# run the application
singularity exec --nv nvidia_test.simg nvidia-smi; echo $CUDA_VISIBLE_DEVICES

```

- CSD3
  - Job submission file on **4 GPU**

```
#!/bin/bash
#!
#! Example SLURM job script for Wilkes2 (Broadwell, ConnectX-4, P100)
#! Last updated: Mon 13 Nov 12:06:57 GMT 2017
#!

#!#############################################################
#!#### Modify the options in this section as appropriate ######
#!#############################################################

#! sbatch directives begin here ###############################
#! Name of the job:
#SBATCH -J nvidia_test
#! Which project should be charged (NB Wilkes2 projects end in '-GPU'):
#SBATCH -A
#! How many whole nodes should be allocated?
#SBATCH --nodes=1
#! How many (MPI) tasks will there be in total?
#! Note probably this should not exceed the total number of GPUs in use.
#SBATCH --ntasks=1
#! Specify the number of GPUs per node (between 1 and 4; must be 4 if nodes>1).
#! Note that the job submission script will enforce no more than 3 cpus per GPU.
#SBATCH --gres=gpu:4
#! How much wallclock time will be required?
#SBATCH --time=00:01:00
#! What types of email messages do you wish to receive?
#SBATCH --mail-type=FAIL
#! Uncomment this to prevent the job from being requeued (e.g. if
#! interrupted by node failure or system downtime):
##SBATCH --no-requeue

#! Do not change:
#SBATCH -p pascal

#! sbatch directives end here (put any additional directives above this line)

#! Notes:
#! Charging is determined by GPU number*walltime.

#! Number of nodes and tasks per node allocated by SLURM (do not change):
numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
#! ############################################################
#! Modify the settings below to specify the application's environment, location
#! and launch method:

#! Optionally modify the environment seen by the application
#! (note that SLURM reproduces the environment at submission irrespective of ~/.bashrc):
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel7/default-gpu              # REQUIRED - loads the basic environment
module unload cuda/8.0
module load cuda/9.0

#! Insert additional module load commands after this line if needed:

#! Full path to application executable:
application="singularity"

#! Run options for the application:
options="exec exec nvidia_test.simg nvidia-smi"

#! Work directory (i.e. where the job will run):
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.

#! Are you using OpenMP (NB this is unrelated to OpenMPI)? If so increase this
#! safe value to no more than 12:
export OMP_NUM_THREADS=1

#! Number of MPI tasks to be started by the application per node and in total (do not change):
np=$[${numnodes}*${mpi_tasks_per_node}]

#! Choose this for a pure shared-memory OpenMP parallel program on a single node:
#! (OMP_NUM_THREADS threads will be created):
CMD="$application $options"

#! Choose this for a MPI code using OpenMPI:
#CMD="mpirun -npernode $mpi_tasks_per_node -np $np $application $options"


###############################################################
### You should not have to change anything below this line ####
###############################################################

cd $workdir
echo -e "Changed directory to `pwd`.\n"

JOBID=$SLURM_JOB_ID

echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"

if [ "$SLURM_JOB_NODELIST" ]; then
        #! Create a machine file:
        export NODEFILE=`generate_pbs_nodefile`
        cat $NODEFILE | uniq > machine.file.$JOBID
        echo -e "\nNodes allocated:\n================"
        echo `cat machine.file.$JOBID | sed -e 's/\..*$//g'`
fi

echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"

echo -e "\nExecuting command:\n==================\n$CMD\n"

eval $CMD
```

## 2. TensorFlow

### Let's create an image:

from **tf_mnist_test.def** let's create an image
```
Bootstrap: docker
From: tensorflow/tensorflow:latest-gpu-py3

%post
  apt-get update;
  apt-get -y install git
  pip3 install requests

  cd /usr/local; git clone https://github.com/tensorflow/models.git


%environment
  export PYTHONPATH=/usr/local/models:$PYTHONPATH
%post
  export PYTHONPATH=/usr/local/models:$PYTHONPATH
```

We create it by executing the following command:
```
sudo singularity build tf_mnist_test.simg tf_mnist_test.def
```

### Executing the image

- Copy the image to the HPC machine

- Submit a job using a job submission file

  - JADE
    - Job submission file on **1 GPU**

```
#!/bin/bash

# set the number of nodes
#SBATCH --nodes=1

# set max wallclock time
#SBATCH --time=01:00:00

# set name of job
#SBATCH --job-name=nvidia_test

# set number of GPUs
#SBATCH --gres=gpu:1

# mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

# send mail to this address
#SBATCH --mail-user=

# queue
#SBATCH --partition=small

module load singularity
export NV_GPU=$CUDA_VISIBLE_DEVICES
export SINGULARITYENV_CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES

export SINGULARITY_CACHEDIR=/tmp

# run the application
singularity exec --nv -B /tmp tf_mnist_test.simg python /usr/local/models/official/mnist/mnist.py
```
