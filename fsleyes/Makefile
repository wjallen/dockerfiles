build:
	docker build -t wjallen/fsleyes:1.4.5 .

run:
	docker run -e DISPLAY=host.docker.internal:0 wjallen/fsleyes:1.4.5 fsleyes

run-remote:
	docker run --rm --net=host -e DISPLAY=$${DISPLAY} -v $${HOME}/.Xauthority:/root/.Xauthority wjallen/fsleyes:1.4.5 fsleyes

run-singularity:
	singularity exec --bind /tmp docker://wjallen/fsleyes:1.4.5 fsleyes
