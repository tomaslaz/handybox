#!/bin/bash

#! sbatch directives begin here ###############################
#! Name of the job:
#SBATCH -J tf_vae_test
#! Which project should be charged (NB Wilkes2 projects end in '-GPU'):
#SBATCH -A T2-CSTI001-GPU
#! How many whole nodes should be allocated?
#SBATCH --nodes=1
#! How many (MPI) tasks will there be in total?
#! Note probably this should not exceed the total number of GPUs in use.
#SBATCH --ntasks=1
#! Specify the number of GPUs per node (between 1 and 4; must be 4 if nodes>1).
#! Note that the job submission script will enforce no more than 3 cpus per GPU.
#SBATCH --gres=gpu:4
#! How much wallclock time will be required?
#SBATCH --time=01:00:00
#! What types of email messages do you wish to receive?
#SBATCH --mail-type=FAIL
#! Uncomment this to prevent the job from being requeued (e.g. if
#! interrupted by node failure or system downtime):
##SBATCH --no-requeue

#! Do not change:
#SBATCH -p pascal


. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel7/default-gpu              # REQUIRED - loads the basic environment
module unload cuda/8.0
module load cuda/9.0

export NV_GPU=$CUDA_VISIBLE_DEVICES
export SINGULARITYENV_CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES
export SINGULARITY_CACHEDIR=/tmp

time singularity exec --nv -B /tmp:/tmp vae.simg python /usr/local/bin/vae.py -max_steps=501 -num_cpus=1 -num_gpus=4
