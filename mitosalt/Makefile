all: build run

build:
	docker build -t wjallen/mitosalt:1.1.1 .

run:
	docker run --rm -it wjallen/mitosalt:1.1.1 /bin/bash

push:
	docker push wjallen/mitosalt:1.1.1
