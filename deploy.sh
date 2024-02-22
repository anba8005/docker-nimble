#!/bin/sh

docker build -t anba8005/docker-nimble:v3.7.13-3 . && \
docker push anba8005/docker-nimble:v3.7.13-3
