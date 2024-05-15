FROM ubuntu:16.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential \
                       git \
                       libavcodec-dev \
                       libavdevice-dev \
                       libavfilter-dev \
                       libboost1.58-all-dev \
                       libfontconfig1-dev \
                       libgdal-dev \
                       libgsl-dev \
                       libqt4-dev \
                       libqtwebkit-dev \
                       libxt-dev \
                       qt4-dev-tools \
                       vim \
                       wget && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://bootstrap.pypa.io/pip/2.7/get-pip.py && \
    python2 get-pip.py && \
    rm get-pip.py && \
    pip install matplotlib

# Install newer version of cmake
RUN wget https://cmake.org/files/v3.16/cmake-3.16.7-Linux-x86_64.tar.gz && \
    tar -xzf cmake-3.16.7-Linux-x86_64.tar.gz && \
    mv cmake-3.16.7-Linux-x86_64 /opt/cmake-3.16.7 && \
    ln -sf /opt/cmake-3.16.7/bin/* /usr/bin/ && \
    rm cmake-3.16.7-Linux-x86_64.tar.gz

# Install blitz
RUN git clone https://github.com/blitzpp/blitz && \
    mkdir -p blitz/build && cd blitz/build && \
    cmake .. && \
    make lib && \
    make install && \
    cd / && \
    rm -rf blitz/

## Install VTK 6.3 from source
RUN git clone https://gitlab.kitware.com/vtk/vtk.git && \
    cd vtk && \
    git checkout v6.3.0 && \
    mkdir build && cd build && \
    cmake -Wno-dev \
          -DVTK_BUILD_ALL_MODULES=ON \
          -DVTK_USE_SYSTEM_FREETYPE=ON \
          .. && \
    make -j4 && \
    make install && \
    cd / && \
    rm -rf vtk/

# Install PanFluExercise
RUN git clone https://github.com/gregjohnson/PanFluExercise && \
    cd PanFluExercise && \
    sed -i 's/filename.toStdString())/filename.toStdString().c_str())/' src/StockpileNetworkWidget.cpp && \
    sed -i 's/vtkRenderingFreeTypeOpenGL/vtkIOMPIImage vtkRenderingFreeTypeFontConfig vtkRenderingMatplotlib/' CMakeLists.txt && \
    mkdir build && cd build && \
    cmake -Wno-dev .. && \
    make -j4 && \
    make install

# Fix a libGL error that pops up when you run
ENV LIBGL_ALWAYS_INDIRECT=1

CMD ["exercise"]

