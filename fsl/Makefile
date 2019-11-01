all: build run

build:
	docker build -t wallen/fsl-cuda:6.0.1-9.2 -f Dockerfile_fsl_6.0.1_cuda_9.2 .

run:
	docker run --rm -it wallen/fsl-cuda:6.0.1-9.2 /bin/bash

deploy:
	docker push wallen/fsl-cuda:6.0.1-9.2
