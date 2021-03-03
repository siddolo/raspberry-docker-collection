#!/usr/bin/env bash
# https://shinobi.video/
# https://hub.docker.com/r/gagara/shinobi-arm64
# 
# Admin interface url: http://HOST_IP:SHINOBI_PORT/super
# Default user: admin@shinobi.video
# Default password: admin

. ./common-env

CONTAINER_NAME=cctv
SHINOBI_PORT=8001

docker run -d \
    --name=${CONTAINER_NAME} \
    --privileged \
    --restart=unless-stopped \
    -p ${SHINOBI_PORT}:8080 \
    -v "/dev/shm/Shinobi/streams":"/dev/shm/streams":"rw" \
    -v "/dev/dri":"/dev/dri":"rw" \
    -v "/etc/localtime":"/etc/localtime":"ro" \
    -v ${VOLUMES_STORAGE_PATH}/${CONTAINER_NAME}-data/config:"/config":"rw" \
    -v ${VOLUMES_STORAGE_PATH}/${CONTAINER_NAME}-data/database:"/var/lib/mysql":"rw" \
    -v ${VOLUMES_STORAGE_PATH}/${CONTAINER_NAME}-data/customAutoLoad:"/home/Shinobi/libs/customAutoLoad":"rw" \
    -v ${VOLUMES_STORAGE_PATH}/${CONTAINER_NAME}-data/videos:"/home/Shinobi/videos":"rw" \
    -v ${VOLUMES_STORAGE_PATH}/${CONTAINER_NAME}-data/plugins:"/home/Shinobi/plugins":"rw" \
    gagara/shinobi-arm64:latest
