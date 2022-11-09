VER ?= 22.3.04

build:
	docker build -f Dockerfile -t wjallen/afni:${VER} .

push:
	docker push wjallen/afni:${VER}

test: 
	docker run --rm -it wjallen/afni:${VER} /bin/bash
