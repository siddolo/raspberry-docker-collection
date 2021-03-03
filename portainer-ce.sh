#!/usr/bin/env bash
# https://documentation.portainer.io/v2.0/deploy/ceinstalldocker/

. ./common-env

CONTAINER_NAME=portainer
PORTAINER_UI_PORT=9000
PORTAINER_TCP_TUNNEL_PORT=8000 # Optional, only required if you plan to
                               # use the Edge compute features.

docker run -d \
    --name ${CONTAINER_NAME} \
    -p 9000:9000 \
    -p 8000:8000 \
     --restart always \
     -v /var/run/docker.sock:/var/run/docker.sock \
     -v ${VOLUMES_STORAGE_PATH}/${CONTAINER_NAME}-data:/data \
     portainer/portainer-ce:alpine
