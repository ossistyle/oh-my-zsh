#!/bin/env bash

source scripts/helper.sh

install_neovim_deps () {
  header "Installing neovim build deps..."

  if [[ -d $HOME/neovim ]]; then
    success "Neovim is already installed. No need to update deps."
    return
  fi

  case $OS_DISTRIBUTION in
    debian|ubuntu)
      deps=(
        ninja-build
        gettext
        libtool
        libtool-bin
        autoconf
        automake
        cmake
        g++
        pkg-config
        unzip
        curl
        doxygen
        cmake
      )
      ;;
    arch|manjaro)
      deps=(
        base-devel
        cmake
        unzip
        ninja
        tree-sitter
        curl
      )
      ;;
    *)
      error "Distro is not supported. Abort"
      exit
      ;;
  esac

  os_install "${deps[@]}"
}

install_neovim () {
  header "Installing Neovim ..."

  clone neovim/neovim "$HOME"
  [[ $? -ne 0 ]] && exit

  info "Building neovim from source..."

  cd "$HOME"/neovim \
    && make distclean \
    && rm -rf "$HOME"/.local/share/nvim/runtime \
    && git checkout v0.10.2 \
    && make \
      CMAKE_BUILD_TYPE=RelWithDebInfo \
      CMAKE_INSTALL_PREFIX="$HOME"/.local install 1> /dev/null \
    && git checkout master \

  success
}

update_neovim_conf () {
  header "Setting up neovim..."

  [[ ! -d $HOME/.config/nvim ]] && mkdir -p "$HOME"/.config/nvim
  cp "$DOTFILES_HOME"/nvim/init.lua "$XDG_CONFIG_HOME"/nvim/init.lua
  cp -r "$DOTFILES_HOME"/nvim/lua "$XDG_CONFIG_HOME"/nvim/lua
}

main () {
  install_neovim_deps
  install_neovim
  update_neovim_conf
}

main