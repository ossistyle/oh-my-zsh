#!/usr/bin/env bash

source scripts/helper.sh

packages=(
  curl
  unzip
  tree
  jq
  bc
  shellcheck
)

header "Installing packages..."
os_install "${packages[@]}"