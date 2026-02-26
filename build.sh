#!/bin/bash
# Build the Infinite-World Docker image.
# Usage: bash build.sh
# Override image name/tag:  IMAGE_NAME=myrepo/infworld IMAGE_TAG=v1 bash build.sh
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE_NAME=${IMAGE_NAME:-infworld}
IMAGE_TAG=${IMAGE_TAG:-latest}

echo "=============================================="
echo "Infinite World - Docker Build"
echo "Image : ${IMAGE_NAME}:${IMAGE_TAG}"
echo "Context: ${SCRIPT_DIR}"
echo "=============================================="

docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" "$SCRIPT_DIR"

echo ""
echo "Build complete: ${IMAGE_NAME}:${IMAGE_TAG}"
