FROM quay.io/fenicsproject/stable:latest AS builder
FROM tacc/tacc-ubuntu18-impi19.0.7-common:latest

RUN apt-get update && apt-get upgrade -y && apt-get install -y python3-pip
RUN pip3 install mpi4py

COPY --from=builder ./ ./


