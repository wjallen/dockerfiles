build:
	docker build -t wjallen/xeyes:0.1 .

run:
	xhost + 127.0.0.1
	docker run -e DISPLAY=host.docker.internal:0 wjallen/xeyes:0.1 xeyes

run-remote:
	docker run --rm --net=host -e DISPLAY=$${DISPLAY} -v $${HOME}/.Xauthority:/root/.Xauthority wjallen/xeyes:0.1 xeyes

run-singularity:
	singularity exec docker://wjallen/xeyes:0.1 xeyes
