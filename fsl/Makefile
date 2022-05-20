all: build run

build:
	docker build -t wjallen/fsl-cuda:6.0.5-11.4 -f Dockerfile_fsl_6.0.5_cuda_11.4 .

run:
	docker run --rm -it wjallen/fsl-cuda:6.0.5-11.4 /bin/bash

deploy:
	docker push wjallen/fsl-cuda:6.0.5-11.4
