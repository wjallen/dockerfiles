FROM ubuntu:latest

RUN apt-get update --fix-missing && apt-get install -y \
    autoconf \
    csh \
    gcc \
    git \
    make \
    gfortran \
    libtool  \
    libomp-dev liblapacke-dev libblas-dev liblapack-dev && \
    apt-get clean

RUN git clone git://git.savannah.gnu.org/gsl.git && \
    cd gsl && \
    ./autogen.sh && \
    ./configure --enable-maintainer-mode && \
    make && make install

RUN cd / && \
    git clone https://github.com/JonathanJerke/Andromeda.git && \
    cd Andromeda && \
    make

ENV OMP_NUM_THREADS 4
ENV LAUNCH /Andromeda/launchPad
ENV PATH=/Andromeda/launchPad/csh:${PATH}
ENV LD_LIBRARY_PATH /usr/local/lib

RUN cd /Andromeda && \
    cp andromeda /Andromeda/launchPad/csh/ && \
    cd launchPad && \
    chmod +x *
