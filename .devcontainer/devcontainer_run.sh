#!/bin/sh

# This script is used by CI/CD to execute a command in the dev container.
# Usage:
#
# devcontainer_cicd <COMMAND>

set -o errexit
set -o nounset

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"
GIT_ROOT=$(realpath ..)

DEVCONTAINER_IMAGE=python_dev_env:latest
DEVCONTAINER_ARTIFACTORY_PATH=ngxp-docker-dev-local/python-dev-container
DEVCONTAINER_IMAGE_URL="$ARTIFACTORY_URL/$DEVCONTAINER_ARTIFACTORY_PATH/$DEVCONTAINER_IMAGE"

if [[ $# -lt 1 ]]; then
    echo "No command provided. Usage:"
    echo "$0 <COMMAND>"
    exit 1
fi

# Build the Docker image (incremental build: first retrieve the latest version from artifactory)
starttime=$(date +%s)
echo "Retrieving image from $ARTIFACTORY_URL"
docker pull "$DEVCONTAINER_IMAGE_URL" || true

elapsedtime=$(( $(date +%s) - starttime ))
echo --------------------
printf "Docker pull took %02d:%02d:%02d\n" $((elapsedtime/3600)) $((elapsedtime/60%60)) $((elapsedtime%60))
echo --------------------

last_docker_id=$(docker inspect --format {{.Id}} "$DEVCONTAINER_IMAGE_URL") || true

# Build the new Docker image
docker build -f Dockerfile.devEnv --cache-from "$DEVCONTAINER_IMAGE_URL" --tag "$DEVCONTAINER_IMAGE" \
    --build-arg USERNAME=$(id -un) --build-arg USER_UID=$(id -u) --build-arg USER_GID=$(id -g) .

# Check if the image has changed. If so, push to Artifactory
new_docker_id=$(docker inspect --format {{.Id}} "$DEVCONTAINER_IMAGE")
if [ "$last_docker_id" != "$new_docker_id" ]; then
    echo "Saving devcontainer for future runs in $DEVCONTAINER_ARTIFACTORY_PATH/$DEVCONTAINER_IMAGE"
    # Write the build id
    docker tag "$DEVCONTAINER_IMAGE" "$DEVCONTAINER_IMAGE_URL"
    docker push "$DEVCONTAINER_IMAGE_URL"
else
    echo "Devcontainer image did not change"
fi

elapsedtime=$(( $(date +%s) - starttime ))
echo --------------------
printf "Build devcontainer took %02d:%02d:%02d\n" $((elapsedtime/3600)) $((elapsedtime/60%60)) $((elapsedtime%60))
echo --------------------

echo "GIT_ROOT: $GIT_ROOT"

# Run the dev container
docker run \
    --rm \
    -v "$GIT_ROOT:/workspaces/python_dev" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /cache:/cache \
    -w /workspaces/python_dev \
    --privileged \
    --cap-add=SYS_ADMIN \
    --cap-add=SYS_PTRACE \
    --security-opt seccomp=unconfined \
    "$DEVCONTAINER_IMAGE" \
    "$*"
