#!/usr/bin/env bash

source ./config.sh

# Install docker on the target host
./env/bin/ansible-playbook ansible/deploy.yml \
  --inventory="$CVAT_TARGET_HOST," \
  --user="$CVAT_TARGET_USER" \
  --private-key="$CVAT_SSH_PRIVATE_KEY" \
  -e user=$CVAT_TARGET_USER

# Deploy the app to the target host
echo "Deploying CVAT to remote host"
docker-compose --context cvat-host -f /tmp/cvat/docker-compose.yml up -d
