FROM codercom/code-server:v2

USER root

RUN apt-get update && apt-get upgrade -y
RUN apt-get install python3 python3-pip -y 
RUN pip3 install jupyter==1.0.0 

USER coder
