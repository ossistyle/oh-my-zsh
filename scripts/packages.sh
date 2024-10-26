#!/usr/bin/env bash

source scripts/helper.sh

packages=(
  curl
  unzip
  tree
  jq
  bc
  shellcheck
  bat
)

header "Installing packages..."
os_install "${packages[@]}"