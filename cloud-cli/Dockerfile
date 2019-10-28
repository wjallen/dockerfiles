FROM python:3.6.6-stretch

# Install python $PYVERSION.
ARG PYVERSION=2.7.15

# Install software dependencies, python 2, and other python dependencies.
RUN apt-get update -y && apt-get install -yq git bash-completion \
    bsdmainutils curl vim expect netcat jq bats tree  \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /src/.*deb \
    && wget https://www.python.org/ftp/python/${PYVERSION}/Python-${PYVERSION}.tgz \
    && tar -xvf Python-${PYVERSION}.tgz \
    && cd Python-${PYVERSION} \
    && ./configure --with-ensurepip=install \
    && make \
    && make altinstall \
    && ln -sf /usr/local/bin/python2.7 /usr/bin/python2 \
    && cd ../ \
    && rm -r Python-${PYVERSION}.tgz Python-${PYVERSION} \
    && pip install sphinx \
    && pip install sphinx-rtd-theme \
    && pip install pytest \
    && pip install yapf \
    && pip2.7 install mock

# Install Docker
RUN apt-get update -y \
    && apt-get install -y apt-transport-https ca-certificates gnupg2 software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && apt-key fingerprint 0EBFCD88 \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update -y \
    && apt-get install -y docker-ce

# Install TACC/agavepy
RUN git clone https://github.com/TACC/agavepy \
    && cd agavepy \
    && make install

# Add cloned submodules 
ADD agave-cli /agave-cli
ADD abaco-cli /abaco-cli

ENV PATH=$PATH:/agave-cli/bin
ENV PATH=$PATH:/abaco-cli
ENV LANG="C.UTF-8"

CMD ["/bin/bash"]
