## Example Dockerfile for spotl

First clone this repo and navigate into this folder.

```
git clone https://github.com/wjallen/spotl-docker
cd spotl-docker/
```

Useful docker commands are stored in the Makefile included in this repo. For example:

<br>

#### To build: `make build`

This will build the docker image locally.

<br>


#### To run interactively: `make run-interactive`

This will build and start an interactive shell.

<br>


#### To test: `make run-test`

This will run the test script located in the test directory inside a container.
(This test should generate, among other things, a bunch of `ex[1-6].f*` in the `test/` folder).

<br> 


#### To clean up after test: `make clean`

This will remove the output files from the test.

<br>


#### To run an example command: `make run-example`

This will run an arbitrary nloadf command and print output to screen.

<br>


## How it may look in a classroom

Instructor should build this Dockerfile and push it to a public repo, e.g.:
```
$ docker build -t instructor/spotl:0.1 .
...
Successfully built 5e89c2aa271f
Successfully tagged instructor/spotl:0.1

$ docker push instructor/spotl:0.1
The push refers to repository [docker.io/instructor/spotl]
ef47facf5961: Pushed 
c66adf4f9572: Pushed 
ca0539940465: Pushed 
d69483a6face: Pushed
0.1: digest: sha256:812e2632c1d9f35feb8e87b9a714889147f631f3efeb8ebd96a0ce273788ad73 size: 1163
```

Now, students can run commands inside the container without installing the software:
```
$ docker pull instructor/spotl:0.1
$ SPOTL="docker run --rm -it -v ${PWD}/test/:/test/ instructor/spotl:0.1 "
$ ${SPOTL} ../bin/nloadf ESNI 40.5963 28.9223 2 m2.osu.tpxo72.2010 green.contap.std l 
S  ESNI                                          40.5963   28.9223        2.
O M2        2 0 0 0 0 0     OSU Global Models (2010): Global Ocean TPXO 7.2   
G   CE       GREEN FUNCTION FOR SHIELD MODEL, TYPED IN FROM FARRELL 1972         
G    Rings from   0.03 to   1.00 spacing 0.01 - detailed grid (ocean), seawater
G    Rings from   1.05 to   9.95 spacing 0.10 - detailed grid (ocean), seawater
G    Rings from  10.25 to  89.75 spacing 0.50 - model grid, seawater
G    Rings from  90.50 to 179.50 spacing 1.00 - model grid, seawater
C   Version 3.3.0.2 of load program, run at Thu Jul 25 16:25:30 2019
C   closest nonzero load was   1.65 degrees away, at   40.58   26.75
C     7941 zero loads found where ocean present, range   0.03-   9.95 deg
L l          Phases are local, lags negative
X
g             0.6383   23.6833
p             5.2236 -154.2456
d             1.1770   83.5864    0.7679 -145.3684    3.6824   18.2732
t             2.9094   52.0150    0.3965  142.0679
s             0.4320 -111.3936    0.9178   27.2202    0.2949  -50.5076
```

The `${SPOTL}` environment variable is just a convenience so the command line isn't so long.
If running multiple consecutive commands, they will need to be written in a bash script in the test directory, and the output will need to be written to `/test/`. E.g.:
```
$ cat test/my_script.sh
../bin/nloadf ..... command 1 >> output1
../bin/nloadf ..... command 2 >> output2
mv output* /test/

$ ${SPOTL} /bin/bash /test/my_script.sh
```




