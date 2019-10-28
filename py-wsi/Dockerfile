FROM centos:7

RUN yum update -y && \
    yum upgrade -y && \
    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install -y \
      gcc \
      git \
      python36 \
      python36-devel \
      python36-pip \
      openslide \
      libffi-devel

RUN rm -f /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python

RUN pip3 install \
    numpy==1.15.2 \
    lmdb==0.93 \
    openslide-python==1.1.1 \
    Shapely==1.6.4 \
    h5py==2.7.0 \
    matplotlib 

RUN cd / && \
    git clone https://github.com/ysbecca/py-wsi

ENV PYTHONPATH "/py-wsi"

