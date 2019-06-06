# source of the base image
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# install environment dependencies
RUN apt-get update; apt-get -y install git python-setuptools python-dev build-essential
RUN easy_install pip

# install TensorFlow with GPU support
RUN pip install tensorflow-gpu

# install TensorFlow Probability library
RUN mkdir -p /usr/local/bin; cd /usr/local/bin; git clone -b r0.5 --single-branch https://github.com/tensorflow/probability.git
ENV PYTHONPATH="$PYTHONPATH:/usr/local/bin/probability"

# set enviromental parameters
ENV DYLD_LIBRARY_PATH="/usr/local/cuda/lib:$DYLD_LIBRARY_PATH"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# add 'TMPDIR' directory for vae.py
RUN mkdir -p /usr/local/tmp
ENV TMPDIR="/usr/local/tmp"

# add the vae.py script that is being developed
ADD vae.py /usr/local/bin/

# execute the script
CMD ["python", "/usr/local/bin/vae.py"]
