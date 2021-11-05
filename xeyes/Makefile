build:
	docker build -t wallen/xeyes:0.1 .

run:
	xhost + 127.0.0.1
	docker run -e DISPLAY=host.docker.internal:0 wallen/xeyes:0.1 xeyes
