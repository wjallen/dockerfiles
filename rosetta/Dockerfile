FROM centos:7

RUN yum -y update \
    && yum -y groupinstall "Development Tools" \
    && yum -y install zlib-devel which wget 

COPY ./rosetta_src_3.10_bundle.tgz / 

RUN tar -xzf rosetta_src_3.10_bundle.tgz \
    && mv rosetta_src_2018.33.60351_bundle/ rosetta_3.10 \
    && cd rosetta_3.10/main/source \
    && ./scons.py mode=release bin \
    && cd / \
    && rm -rf rosetta_src_3.10_bundle.tgz \
    && rm -rf /rosetta_3.10/demos \


