FROM ubuntu:20.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y liblapack3 wget zip

RUN wget https://github.com/boecker-lab/sirius/releases/download/v5.7.3/sirius-5.7.3-linux64.zip && \
    unzip sirius-5.7.3-linux64.zip && \
    rm sirius-5.7.3-linux64.zip 

ENV PATH="/sirius/bin:$PATH"
