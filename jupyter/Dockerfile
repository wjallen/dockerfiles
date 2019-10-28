FROM ubuntu:bionic
LABEL maintainer="Erik Ferlanti <eferlanti@tacc.utexas.edu>"

ARG NB_USER="jupyter"
ARG NB_UID="1000"
ARG NB_GID="100"

USER root

# Install OS dependencies
RUN apt-get update && apt-get -yq dist-upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
       build-essential \
       bzip2 \
       ca-certificates \
       curl \
       fonts-liberation \
       git \
       inkscape \
       jed \
       jq \
       libsm6 \
       libxext-dev \
       libxrender1 \
       lmodern \
       locales \
       netcat \
       pandoc \
       python-dev \
       sudo \
       texlive-fonts-extra \
       texlive-generic-recommended \
       texlive-latex-base \
       texlive-latex-extra \
       texlive-xetex \
       tzdata \
       unzip \
       vim \
       wget \
    && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# Configure environment
ENV CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    NB_USER=${NB_USER} \
    NB_UID=${NB_UID} \
    NB_GID=${NB_GID} \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
ENV PATH=${CONDA_DIR}/bin:$PATH \
    HOME=/home/${NB_USER}

# Add jupyter helper scripts
ARG BURL=https://raw.githubusercontent.com/jupyter/docker-stacks/master/base-notebook
RUN bash -c "cd /usr/local/bin && for target in fix-permissions start{\"\",-notebook,-singleuser}.sh; do wget -q ${BURL}/\$target && chmod a+rx \$target; done" && \
    mkdir /etc/jupyter && cd /etc/jupyter && wget -q ${BURL}/jupyter_notebook_config.py && \
    fix-permissions /etc/jupyter /usr/local/bin

# Enable prompt color in the skeleton .bashrc before creating the default NB_USER
RUN sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' /etc/skel/.bashrc

# Create NB_USER (will be added to 'users' group)
RUN useradd -m -s /bin/bash -N -u ${NB_UID} ${NB_USER} && \
    mkdir -p ${CONDA_DIR} && \
    chown ${NB_USER}:${NB_GID} ${CONDA_DIR} && \
    fix-permissions ${HOME} && \
    fix-permissions "$(dirname ${CONDA_DIR})"

# Switch to jupyter user to install miniconda
USER ${NB_USER}
WORKDIR ${HOME}

RUN mkdir /home/${NB_USER}/work && fix-permissions ${HOME}

ENV MINICONDA_VERSION=4.6.14 \
    CONDA_VERSION=4.7.5

RUN cd /tmp && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    echo "718259965f234088d785cad1fbd7de03 *Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh" | md5sum -c - && \
    /bin/bash Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -f -b -p ${CONDA_DIR} && \
    rm Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    ${CONDA_DIR}/bin/conda config --system --set auto_update_conda false && \
    ${CONDA_DIR}/bin/conda config --system --set show_channel_urls true && \
    ${CONDA_DIR}/bin/conda install --quiet --yes conda && \
    ${CONDA_DIR}/bin/conda update --all --quiet --yes && \
    conda list python | grep '^python ' | tr -s ' ' | cut -d '.' -f 1,2 | sed 's/$/.*/' >> ${CONDA_DIR}/conda-meta/pinned && \
    conda clean --all -f -y && \
    rm -rf ${HOME}/.cache/yarn && \
    fix-permissions ${CONDA_DIR} && \
    fix-permissions ${HOME}

# Install Jupyter Notebook, Lab, and Hub
RUN conda install --quiet --yes -c defaults -c conda-forge \
    'notebook=5.7.8' \
    'jupyterhub=1.0.0' \
    'jupyterlab=1.0.1' \
    'matplotlib' \
    'pandas' && \
    conda clean --all -f -y && \
    npm cache clean --force && \
    jupyter notebook --generate-config && \
    rm -rf ${CONDA_DIR}/share/jupyter/lab/staging && \
    rm -rf ${HOME}/.cache/yarn && \
    fix-permissions ${CONDA_DIR} && \
    fix-permissions ${HOME}

# Install Tini
RUN conda install --quiet --yes 'tini=0.18.0' && \
    conda list tini | grep tini | tr -s ' ' | cut -d '.' -f 1,2 | sed 's/$/.*/' >> ${CONDA_DIR}/conda-meta/pinned && \
    conda clean --all -f -y && \
    fix-permissions ${CONDA_DIR} && \
    fix-permissions ${HOME}

EXPOSE 8888

# Configure container startup
ENTRYPOINT [ "tini", "-g", "--" ]
CMD [ "start-notebook.sh" ]

# Fix permissions on /etc/jupyter as root
USER root
RUN fix-permissions /etc/jupyter/

# Switch back to jupyter user to run notebook
USER ${NB_USER}

# Import matplotlib the first time to build the font cache.
RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions ${HOME}
