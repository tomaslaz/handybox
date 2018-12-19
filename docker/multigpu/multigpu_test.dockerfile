FROM nvidia/cuda:9.2-devel-ubuntu16.04 as base

# Installing git
RUN apt-get update
RUN apt-get -y install git

# Cloning the test directory
RUN cd /usr/local/; git clone https://github.com/tomaslaz/handybox.git

# Compiling the code
RUN cd usr/local/handybox/docker/multigpu/0_Simple/simpleMultiGPU; make

# Adding the execution script
RUN chmod +x /usr/local/handybox/docker/multigpu/jobExecute.sh

# Execute
CMD /usr/local/handybox/docker/multigpu/jobExecute.sh
