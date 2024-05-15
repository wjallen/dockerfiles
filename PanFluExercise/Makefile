build:
	docker build -t wjallen/pfe:1.0 .

test:
	docker run --rm -it wjallen/pfe:1.0 /bin/bash

run:
	xhost + 127.0.0.1
	docker run -e DISPLAY=host.docker.internal:0 wjallen/pfe:1.0 exercise
