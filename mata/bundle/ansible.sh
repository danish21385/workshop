#!/bin/bash
set -e

# Optional vars file
VAR_FILE=${1:-}

# Playbook path (relative to ansible/)
PLAYBOOK="disk_space_playbook.yaml"

# Resolve repo root (mata/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Running Ansible playbook: ansible/$PLAYBOOK"
echo "Mounting $REPO_ROOT to /workspace"

CMD=(
  docker run --rm
  -v "$REPO_ROOT:/workspace"
  -w /workspace/ansible
  ghcr.io/ansible/community-ansible-dev-tools:latest
  ansible-playbook "$PLAYBOOK"
  -i localhost,
  -c local
)

if [[ -n "$VAR_FILE" ]]; then
  echo "Using variable file: $VAR_FILE"
  CMD+=(-e "@$VAR_FILE")
fi

"${CMD[@]}"
