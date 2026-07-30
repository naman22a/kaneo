#!/usr/bin/env bash

set -Eeuo pipefail

readonly TF_DIR="./infra/terraform"
readonly ANSIBLE_DIR="./infra/ansible"

usage() {
    echo "Usage: $0 <workspace>"
    echo
    echo "Example:"
    echo "  $0 stg"
    echo "  $0 prd"
    exit 1
}

[[ $# -eq 1 ]] || usage

WORKSPACE="$1"

echo "==> Selecting Terraform workspace: $WORKSPACE"

terraform -chdir="$TF_DIR" workspace select "$WORKSPACE" \
    || terraform -chdir="$TF_DIR" workspace new "$WORKSPACE"

echo "==> Applying Terraform"

terraform -chdir="$TF_DIR" apply -auto-approve

INVENTORY="$ANSIBLE_DIR/$WORKSPACE/hosts"
PLAYBOOK="$ANSIBLE_DIR/playbooks/site.yml"

[[ -f "$INVENTORY" ]] || {
    echo "Inventory not found: $INVENTORY"
    exit 1
}

[[ -f "$PLAYBOOK" ]] || {
    echo "Playbook not found: $PLAYBOOK"
    exit 1
}

echo "==> Running Ansible"

ansible-playbook \
    -i "$INVENTORY" \
    "$PLAYBOOK"

echo "==> Deployment complete"
