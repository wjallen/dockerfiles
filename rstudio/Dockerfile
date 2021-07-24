FROM ppc64le/ubuntu:18.04

ARG R_VERSION=4.1.0
ARG RSTUDIO_VERSION=1.4.1717
ENV LC_ALL="C.UTF-8"
ENV DEBIAN_FRONTEND="noninteractive"

# dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
                 build-essential \
                 curl \
                 gfortran \
                 git \
                 libbz2-dev \
                 libcurl4-openssl-dev \
                 liblzma-dev \
                 libpcre2-dev \
                 libreadline-dev \
                 lsb-release \
                 wget \
                 xorg-dev \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn \
    && apt-get clean

# install R
RUN wget https://cran.r-project.org/src/base/R-4/R-${R_VERSION}.tar.gz \
    && tar -xvzf R-${R_VERSION}.tar.gz \
    && cd R-${R_VERSION} \
    && ./configure --enable-R-shlib \
    && make -j4 \
    && make install \
    && cd / \
    && rm -rf R-${R_VERSION}.tar.gz R-${R_VERSION}/

# dependencies for Rstudio
RUN wget https://github.com/rstudio/rstudio/archive/refs/tags/v${RSTUDIO_VERSION}.tar.gz \
    && tar -xvzf v${RSTUDIO_VERSION}.tar.gz \
    && cd rstudio-${RSTUDIO_VERSION}/dependencies/linux \
    && sed -i 's/sudo//g' install-dependencies-bionic \
    && sed -i 's/amd64/ppc64el/g' install-dependencies-bionic \
    && echo "exit 0" > /rstudio-${RSTUDIO_VERSION}/dependencies/common/install-crashpad \
    && echo "exit 0" > /rstudio-${RSTUDIO_VERSION}/dependencies/common/install-sentry-cli \
    && ./install-dependencies-bionic \
    && apt-get clean

# install Rstudio
RUN mkdir -p /rstudio-${RSTUDIO_VERSION}/build/ \
    && cd /rstudio-${RSTUDIO_VERSION}/build/ \
    && cmake -j4 \
             -DRSTUDIO_TARGET=Server \
             -DCMAKE_BUILD_TYPE=Release \
             ../ \
    && make -j4 \
    && make install \
    && rm -rf /rstudio-${RSTUDIO_VERSION} 

# set up Rstudio
RUN cp /usr/local/extra/init.d/debian/rstudio-server /etc/init.d/ \
    && useradd -r rstudio-server \
    && cp /usr/local/extras/init.d/debian/rstudio-server /etc/init.d/ \
    && update-rc.d rstudio-server defaults \
    && ln -f -s /usr/local/bin/rstudio-server /usr/sbin/rstudio-server \
    && mkdir -p /var/run/rstudio-server \
    && mkdir -p /var/lock/rstudio-server \
    && mkdir -p /var/log/rstudio-server \
    && mkdir -p /var/lib/rstudio-server \
    && set -e \
    && useradd -m -d /home/rstudio -G sudo rstudio \
    && echo rstudio:rstudio | chpasswd \
    && rstudio-server online \
    && cd / \
    && echo -e '#!/bin/bash\ncd /usr/sbin\nrstudio-server start' >> startup.sh \
    && chmod +x startup.sh

EXPOSE 8787
VOLUME /home/rstudio
CMD /startup.sh ; sleep infinity
