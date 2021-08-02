build:
	docker build -t wallen/rstudio:1.4.1717 .

push:
	docker push wallen/rstudio:1.4.1717

pull:
	singularity pull docker://wallen/rstudio:1.4.1717

pull-dev:
	singularity pull docker-daemon:wallen/rstudio:1.4.1717

clean:
	rm -f rstudio_1.4.1717.sif rstudio.out rstudio.log
	rm -rf ~/.rstudio/run/rstudio-server/*

superclean: clean
	docker rmi wallen/rstudio:1.4.1717
	singularity cache clean

cycle: clean build push pull

docker:
	docker run --rm -it -p 8787:8787 wallen/rstudio:1.4.1717 /bin/bash

sing:
	singularity run -B /home/03439/wallen/.rstudio/var/lib/rstudio-server:/var/lib/rstudio-server \
                        -B /home/03439/wallen/.rstudio/var/run/rstudio-server:/var/run/rstudio-server \
                        rstudio_1.4.1717.sif /bin/bash


# PASSWORD='example' rserver --auth-none=0 --auth-pam-helper-path=/usr/local/bin/pam-helper
