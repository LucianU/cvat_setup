#!/usr/bin/env bash

# Required arguments: HOST, USER, SSH PRIVATE KEY

# Install docker on the target host
ansible-playbook ansible/deploy \
  --inventory="$1," \
  --user="$2" \
  --private-key="$3"

# Clone the CVAT project
git clone https://github.com/openvinotoolkit/cvat /tmp/

# Create the Docker context for the target host
docker context create cvat-host --docker host="ssh://$2@$1"

# Deploy the app to the target host
docker-compose --context cvat-host -f /tmp/cvat/docker-compose.yml up -d
