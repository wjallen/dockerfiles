FROM centos:7.9.2009

RUN yum update -y && \
    yum upgrade -y && \
    yum group install -y "Development Tools" && \
    yum install -y wget

RUN yum install -y epel-release && \
    yum install -y R  \
                   ncurses-devel

RUN wget https://sourceforge.net/projects/mitosalt/files/MitoSAlt_1.1.1.zip/download --no-check-certificate && \
    mv download MitoSAlt_1.1.1.zip && \
    unzip MitoSAlt_1.1.1.zip 

WORKDIR /MitoSAlt_1.1.1/

ADD setup_tools_only.sh /MitoSAlt_1.1.1/setup_tools_only.sh
RUN ./setup_tools_only.sh

ADD setup_custom.sh /MitoSAlt_1.1.1/setup_custom.sh
RUN HUMAN=yes ./setup_custom.sh && \
    THREADS=1 HINDEX=yes ./setup_custom.sh

#RUN MOUSE=yes ./setup_custom.sh && \
#    THREADS=1 MINDEX=yes ./setup_custom.sh

RUN R -e "install.packages(c('BiocManager'), dependencies=TRUE, repos='http://cran.rstudio.com/')" && \
    R -e "BiocManager::install(c('Biostrings'))" && \
    R -e "install.packages(c('RColorBrewer', 'plotrix'), dependencies=TRUE, repos='http://cran.rstudio.com/')" 

RUN mv /MitoSAlt_1.1.1/config_human.txt /MitoSAlt_1.1.1/bak-config_human.txt && \
    mv /MitoSAlt_1.1.1/config_mouse.txt /MitoSAlt_1.1.1/bak-config_mouse.txt

ADD setup_dirs.sh /MitoSAlt_1.1.1/setup_dirs.sh
RUN chmod go=u /MitoSAlt_1.1.1/setup_dirs.sh

RUN sed -i 's/delplot.R/\/MitoSAlt_1.1.1\/delplot.R/' MitoSAlt1.1.1.pl

RUN yum clean all && \
    rm /MitoSAlt_1.1.1.zip && \
    rm /anaconda-post.log  && \
    rm /MitoSAlt_1.1.1/setup.log


