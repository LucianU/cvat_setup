#!/usr/bin/env bash

source ./config.sh

CVAT_REPO_URL="https://github.com/openvinotoolkit/cvat"
CVAT_CLONE_TARGET_PATH="/tmp/cvat"

if [ ! -d env ]
then
  echo "Creating local virtual env..."
  python3 -m venv env
fi

echo "Installing Python libraries..."
./env/bin/pip install -r pip-requirements.txt

hash docker-compose 2>/dev/null || echo "Please install docker-compose."

# Clone the CVAT repo
if [ ! -d "${CVAT_CLONE_TARGET_PATH}" ]
then
  echo "Cloning CVAT repo..."
  git clone "${CVAT_REPO_URL}" "${CVAT_CLONE_TARGET_PATH}"
else
  echo "CVAT has already been cloned."
fi

# Create the Docker context for the target host
echo "Creating Docker Context for target host..."
docker context create cvat-host --docker host="ssh://$CVAT_TARGET_USER@$CVAT_TARGET_HOST"