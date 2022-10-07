#!/usr/bin/env bash 

f=$(realpath $( dirname $0 )/./dovecot-docker-append.txt)
dir=$(dirname $0)/../mailcow-dockerized/data/Dockerfiles/dovecot
cd $dir



sed -i \
 -e '/gosu nobody true/s/\\/ /' \
 -e '/repo\.dovecot\.org/s/^/#/'  \
 -e '/dovecot-lua/s/dovecot-lua/dovecot-auth-lua/'  \
 -e "/gosu nobody true/a\  RUN echo 'dovecot-arm64' \\\\" \
Dockerfile;


