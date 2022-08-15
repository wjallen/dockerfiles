VER ?= 4.0

build:
	docker build -f Dockerfile.${VER} -t wjallen/relion:${VER} .

push:
	docker push wjallen/relion:${VER}

test: 
	docker run --rm -it wjallen/relion:${VER} /bin/bash
