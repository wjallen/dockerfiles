FROM microsoft/dotnet:2.1-sdk


RUN git clone https://github.com/Illumina/Pisces \
    && mv Pisces/binaries/5.2.9.122 app \
    && rm -rf Pisces \
    && cd app/ \
    && ls *.tar.gz | xargs -i tar -xvzf {} \
    && rm -rf *.tar.gz



