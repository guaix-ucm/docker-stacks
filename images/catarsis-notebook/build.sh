#!/bin/bash

# Get current date and git commit hash
BUILD_DATE=$(date -Iseconds)
BUILD_DATE_SHORT=$(date +%F)
VCS_REF=$(git rev-parse --short HEAD)

BASE_REG_ID="quay.io/guaix-ucm"
IMAGE_DESC="catarsis-notebook"
IMAGE_NAME="$BASE_REG_ID/$IMAGE_DESC"

# Build the Docker image with labels
podman build --format docker \
    --build-arg BUILD_DATE="$BUILD_DATE" \
    --build-arg VCS_REF="$VCS_REF" \
    -t "$IMAGE_NAME:latest"  \
    -t "$IMAGE_NAME:$BUILD_DATE_SHORT" \
    .
