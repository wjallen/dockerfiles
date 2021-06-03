FROM ubuntu:18.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential libperl-dev wget

RUN cd /opt && \
    wget https://github.com/WGLab/PennCNV/archive/refs/tags/v1.0.5.tar.gz && \
    tar -xzf v1.0.5.tar.gz && \
    rm v1.0.5.tar.gz

RUN cd /opt/PennCNV-1.0.5/kext && \
    make

ENV PATH=/opt/PennCNV-1.0.5:$PATH
ENV PATH=/opt/PennCNV-1.0.5/affy/bin:$PATH

