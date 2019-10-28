#!/bin/bash

docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock cloud-cli-env:1.0
