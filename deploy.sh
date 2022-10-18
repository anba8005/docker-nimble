#!/bin/sh

docker build -t anba8005/docker-nimble:v3.7.11-3 . && \
docker push anba8005/docker-nimble:v3.7.11-3
