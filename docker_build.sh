#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <image_base_name> <platform>"
    exit 1
fi

IMAGE_BASE_NAME=$1
PLATFORM=$2
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
IMAGE_NAME="${IMAGE_BASE_NAME}_${PLATFORM}_${GIT_BRANCH}"

docker build \
    --platform $PLATFORM \
    -t ${IMAGE_NAME} .
