all: build run

build:
	docker build -t wallen/fsl-cuda:6.0.4-11.4 -f Dockerfile_fsl_6.0.4_cuda_11.4 .

run:
	docker run --rm -it wallen/fsl-cuda:6.0.4-11.4 /bin/bash

deploy:
	docker push wallen/fsl-cuda:6.0.4-11.4
