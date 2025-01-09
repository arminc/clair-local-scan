#!/bin/bash

set -ex

FINAL_IMAGE="arminc/clair-db-v4"
ARCHS="${ARCHS:-linux/amd64,linux/arm64}"
HOST_FOLDER="/mnt/postgres"

echo "Building multi-architecture Docker image..."

docker buildx create --use --name multiarch_builder || docker buildx use multiarch_builder

sudo chown -R root:root "${HOST_FOLDER}"

sudo ls -alh /mnt
sudo ls -alh "${HOST_FOLDER}"

docker buildx build --platform "${ARCHS}" \
    -t "${FINAL_IMAGE}:$(date +%Y-%m-%d)" -t "${FINAL_IMAGE}:latest" \
    --build-context postgres="${HOST_FOLDER}" \
    --progress=plain \
    --push postgres

echo "Done! Multi-arch image '${FINAL_IMAGE}' has been built and pushed."
