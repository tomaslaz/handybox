FROM nvidia/cuda:9.2-devel-ubuntu16.04 as base

# Compiling the example
RUN cd /usr/local/; RUN git clone https://github.com/tomaslaz/handybox.git

# Adding the execution script
RUN chmod +x /usr/local/handybox/docker/multigpu/jobExecute.sh

# Execute
CMD /usr/local/handybox/docker/multigpu/jobExecute.sh
