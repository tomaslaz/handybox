
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

### get git
RUN apt-get update; apt-get -y install git
RUN apt-get update; apt-get -y install python-setuptools python-dev build-essential
RUN easy_install pip

### install tensorflow
RUN pip install tensorflow-gpu

# Install additional software from TensorFlow Probability
RUN mkdir -p /usr/local/bin; cd /usr/local/bin; git clone -b r0.5 --single-branch https://github.com/tensorflow/probability.git
ENV PYTHONPATH="$PYTHONPATH:/usr/local/bin/probability"

ENV DYLD_LIBRARY_PATH="/usr/local/cuda/lib:$DYLD_LIBRARY_PATH"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# 'TMPDIR'
RUN mkdir -p /usr/local/tmp
ENV TMPDIR="/usr/local/tmp"

# Copy the modified vae.py
ADD vae.py /usr/local/bin/

# Execute the script
CMD ["python", "/usr/local/bin/vae.py"]
