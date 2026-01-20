#!/bin/bash

# Exit on error
set -e

# Accept an optional variable file as the first argument
VAR_FILE=${1:-}  # empty by default

# Fixed playbook
PLAYBOOK="ansible/playbook1.yaml"

echo "Running Ansible playbook: $PLAYBOOK"

# Build docker command
DOCKER_CMD="docker run --rm \
  -v \"$(pwd):/workspace\" \
  -w /workspace \
  ghcr.io/ansible/community-ansible-dev-tools:latest \
  ansible-playbook $PLAYBOOK -i \"localhost,\" -c local"

# If a variable file is provided, append it
if [[ -n "$VAR_FILE" ]]; then
  echo "Using variable file: $VAR_FILE"
  DOCKER_CMD="$DOCKER_CMD -e @$VAR_FILE"
fi

# Run the command
eval $DOCKER_CMD
