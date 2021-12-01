#!/usr/bin/env bash

# Required arguments: HOST, USER, SSH PRIVATE KEY
if [ "$#" -ne 3 ];
then
  echo "3 arguments required: HOST, USER, SSH PRIVATE KEY"
  echo "$# provided"
  exit 1
fi

# Install docker on the target host
./env/bin/ansible-playbook ansible/deploy.yml \
  --inventory="$1," \
  --user="$2" \
  --private-key="$3" \
  -e user=$2

# Deploy the app to the target host
echo "Deploying CVAT to remote host"
docker-compose --context cvat-host -f /tmp/cvat/docker-compose.yml up -d
