FROM ubuntu:22.04

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common && \
    apt-get update -y && \
    add-apt-repository -y universe && \
    apt-get update -y

RUN DEBIAN_FRONTEND=noninteractive TZ=America/Chicago apt-get install -y tzdata
 
RUN apt-get install -y tcsh xfonts-base libssl-dev       \
                       python-is-python3                 \
                       python3-matplotlib python3-numpy  \
                       gsl-bin netpbm gnome-tweaks       \
                       libjpeg62 xvfb xterm vim curl     \
                       gedit evince eog                  \
                       libglu1-mesa-dev libglw1-mesa     \
                       libxm4 build-essential            \
                       libcurl4-openssl-dev libxml2-dev  \
                       libgfortran-11-dev libgomp1       \
                       gnome-terminal nautilus           \
                       firefox xfonts-100dpi             \
                       r-base-dev cmake                  \
                       libgdal-dev libopenblas-dev       \
                       libnode-dev libudunits2-dev

RUN ln -s /usr/lib/x86_64-linux-gnu/libgsl.so.27 /usr/lib/x86_64-linux-gnu/libgsl.so.19

RUN cd /root/ && \
    curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries && \
    tcsh @update.afni.binaries -package linux_ubuntu_16_64 -do_extras && \
    chmod go+rx /root/ 

ENV PATH /root/abin:$PATH
ENV R_LIBS /root/R

RUN mkdir $R_LIBS && \
    rPkgsInstall -pkgs ALL


RUN R -e "install.packages(c('nlme', \
                             'lme4', \
                             'phia'), \
                             dependencies=TRUE, \
                             repos='http://cran.rstudio.com/')" \

# afni_system_check.py -check_all 
# ...
# please run: cp /root/abin/AFNI.afnirc ~/.afnirc
# please run: "suma -update_env" for .sumarc
# please run: apsearch -update_all_afni_help

