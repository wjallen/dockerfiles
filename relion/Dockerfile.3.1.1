FROM tacc/tacc-ubuntu18-mvapich2.3-ib

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y cmake git build-essential mpi-default-bin mpi-default-dev libfftw3-dev libtiff-dev && \
    apt-get install -y freeglut3-dev libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev software-properties-common

RUN add-apt-repository -y ppa:graphics-drivers/ppa && \
    apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" | tee /etc/apt/sources.list.d/cuda.list && \
    apt-get update -y && \
    apt-get -o Dpkg::Options::="--force-overwrite" install -y cuda-10-1 cuda-drivers

RUN mkdir /app && \
    cd /app && \
    git clone https://github.com/3dem/relion.git && \
    cd relion && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/app/relion-3.1.1 -DGUI=OFF .. && \
    make -j2 && \
    make install

ENV PATH=/app/relion-3.1.1/bin:${PATH}

