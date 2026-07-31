#!/usr/bin/env bash

set -Eeuo pipefail

readonly TF_DIR="./infra/terraform"

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

terraform -chdir="$TF_DIR" workspace select "$WORKSPACE" \
    || terraform -chdir="$TF_DIR" workspace new "$WORKSPACE"

echo "==> Destroying using Terraform"

terraform -chdir="$TF_DIR" destroy -auto-approve
