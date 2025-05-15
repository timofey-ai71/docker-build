#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <image_base_name> <platform>"
    exit 1
fi

IMAGE_BASE_NAME=$1
PLATFORM=$2
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
IMAGE_NAME="${IMAGE_BASE_NAME}_${PLATFORM}_${GIT_BRANCH}"

TOOL_VERSIONS_FILE=".tool-versions"
if [ -f $TOOL_VERSIONS_FILE ]; then
    POETRY_VERSION=$(cat $TOOL_VERSIONS_FILE | grep poetry | cut -d' ' -f2)
else
    echo "No .tools-versions file found. Using default Poetry version."
    exit 1
fi

docker build \
    --platform $PLATFORM \
    --build-arg POETRY_VERSION=${POETRY_VERSION} \
    -t ${IMAGE_NAME} .
