FROM nvidia/cuda:12.4.1-cudnn-runtime-ubuntu22.04

# Update OS / Install Python
RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3.10-full python3-pip python-is-python3 git && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/MAGICS-LAB/DNABERT_2 && \
    cd DNABERT_2 && \
    pip install -r requirements.txt
