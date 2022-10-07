#!/usr/bin/env bash 

f=$(realpath $( dirname $0 )/./sogo-docker-append.txt)
sogo_dir=$(dirname $0)/../mailcow-dockerized/data/Dockerfiles/sogo
cd $sogo_dir


sed  -i  '/keys\.openpgp\.org/,+6 d' Dockerfile 
grep arm64 Dockerfile > /dev/null || sed -i "/locale/r${f}" Dockerfile
