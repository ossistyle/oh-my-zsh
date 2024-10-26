#!/usr/bin/env bash

source scripts/helper.sh

install_git() {
  header "Installing git..."
  os_install git
}

install_gitconfig() {
  header "Deploying git config"

  if [[ -f "$HOME"/.gitconfig ]]; then
    cp "$HOME"/.gitconfig "$HOME"/gitconfig.bak
    warning "Backed up .gitconfig"
  fi

  GIT_FULLNAME="Thomas 'ossistyle' Hoffmann"
  GIT_EMAIL=ossistyle@gmail.com

  cp "$DOTFILES_HOME"/git/gitconfig.template "$HOME"/.gitconfig
  sed -i \
    -e "s|FULL_NAME|$GIT_FULLNAME|g" \
    -e "s|GIT_EMAIL|$GIT_EMAIL|g" \
    "$HOME"/.gitconfig

  success
}

main() {
  install_git
  install_gitconfig
}

main
