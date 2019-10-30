all: build run

build:
	docker build -t jupyter_notebook:1.0 .

run:
	docker run -it -p 8888:8888 jupyter_notebook:1.0
