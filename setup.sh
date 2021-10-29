#!/usr/bin/env bash

python3 -m venv env

./env/bin/pip install -r pip-requirements.txt

hash docker-compose 2>/dev/null || echo "Please install docker-compose."