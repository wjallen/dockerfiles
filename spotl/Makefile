build:
	docker build -t spotl:0.1 .

run-interactive: build
	docker run --rm -it spotl:0.1 /bin/bash

run-test: build
	docker run --rm -it -v ${PWD}/test/:/test/ spotl:0.1 /bin/bash -c "cp Exampl/* ./; ./ex1.scr; ./ex2.scr; ./ex3.scr; ./ex4.scr; ./ex5.scr; ./ex6.scr; mv ex* /test/"

run-example:
	docker run --rm -it -v ${PWD}/test/:/test/ spotl:0.1 ../bin/nloadf ESNI 40.5963 28.9223 2 m2.osu.tpxo72.2010 green.contap.std l

clean:
	rm -f test/ex*

