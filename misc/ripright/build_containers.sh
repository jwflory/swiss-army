#!/usr/bin/bash
#
# Build Fedora 29 containers with Ripright using Podman/Buildah.

DATE=$(date +%Y-%m-%d)
PODMAN_BUILD="sudo podman build"
PODMAN_TAG="sudo podman tag"

logger -s -p user.info -t $0 "Building ripright-single:$DATE..."
$PODMAN_BUILD -f Dockerfile.ripright-single -t ripright-single:$DATE .
$PODMAN_TAG ripright-single:$DATE ripright-single:latest

logger -s -p user.info -t $0 "Building ripright-multi:$DATE..."
$PODMAN_BUILD -f Dockerfile.ripright-multi -t ripright-multi:$DATE .
$PODMAN_TAG ripright-multi:$DATE ripright-multi:latest
