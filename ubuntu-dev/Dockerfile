FROM ubuntu:16.04

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y bsdmainutils curl git jq vim wget python3 python3-pip docker.io \
    && ln -s /usr/bin/python3 /usr/bin/python

RUN pip3 install agavepy \
    && cd /root/ \
    && git clone https://github.com/TACC/agavepy  \
    && cd agavepy/  \
    && python3 setup.py install


RUN curl -L https://raw.githubusercontent.com/sd2e/sd2e-cli/master/install/install.sh | sh

