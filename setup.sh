#!/usr/bin/env bash

if [ "$#" -ne 2 ]
then
  echo "2 arguments required: HOST, USER"
  echo "$# provided"
  exit 1
fi

PYTHON_ENV_DIR="env"
CVAT_REPO_URL="https://github.com/openvinotoolkit/cvat"
CLONE_TARGET_PATH="/tmp/cvat"

if [ ! -d env ]
then
  echo "Creating local virtual env..."
  python3 -m venv env
fi

echo "Installing Python libraries..."
./env/bin/pip install -r pip-requirements.txt

hash docker-compose 2>/dev/null || echo "Please install docker-compose."

# Clone the CVAT repo
if [ ! -d "${CLONE_TARGET_PATH}" ]
then
  echo "Cloning CVAT repo..."
  git clone "${CVAT_REPO_URL}" /tmp/cvat
else
  echo "CVAT has already been cloned."
fi

# Create the Docker context for the target host
echo "Creating Docker Context for target host..."
docker context create cvat-host --docker host="ssh://$2@$1"