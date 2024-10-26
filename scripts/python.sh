#!/usr/bin/env bash

source scripts/helper.sh

devenv=$HOME/.python

install_deps() {
  header "Installing python deps..."

  packages=(
    zlib1g-dev
    libncurses5-dev
    libgdbm-dev
    libnss3-dev
    libssl-dev
    libreadline-dev
    libffi-dev
    wget
    make 
    build-essential 
    libssl-dev 
    zlib1g-dev
    libbz2-dev 
    libreadline-dev 
    libsqlite3-dev 
    curl 
    llvm
    libncurses5-dev 
    libncursesw5-dev 
    xz-utils 
    tk-dev
  )

  os_install "${packages[@]}"
}

setup_env() {
  header "Setting up dev environment..."

  local devver=3.13.0

  if [[ -d $devenv ]]; then
    success "Already exists"
    return
  fi

  download https://www.python.org/ftp/python/"$devver"/Python-"$devver".tgz "$HOME"
  
  rm -rf "$devenv"
  mkdir -p "$devenv"
  rm -rf "$HOME"/Python-$devver
  mkdir "$HOME"/Python-$devver
  tar xvf "$HOME"/Python-$devver.tgz -C "$HOME"

  cp -rf "$HOME"/Python-$devver/* "$devenv"
  rm -rf "$HOME"/Python-$devver

  info "Build python ..."
  cd "$devenv" && ./configure --enable-optimizations --with-ensurepip=install 1> /dev/null && make 1> /dev/null && sudo make install 1> /dev/null

  #   info "Installing venv..."
  #   "$HOME/.local/bin/python$devver" "$HOME"/virtualenv.pyz "$devenv" --quiet
  #   rm "$HOME"/virtualenv.pyz

  success 
}

install_python_tools() {
  header "Installing python packages..."

  packages=(
    virtualenv
    ptpython
    ruff
    ruff-lsp
    uv
    isort
    mypy
    flake8
    black
    python-lsp-server
  )

  [[ ! $PATH == *$devenv/bin* ]] && export PATH=$devenv/bin:$PATH
  pip3 install -U "${packages[@]}" | grep -E "installed"

  success
}

symlink_configs() {
  header "Setting up python tools configs..."

  symlink "$DOTFILES_HOME"/ptpython.py "$XDG_CONFIG_HOME"/ptpython/config.py
}

install_poetry() {
  header "Installing poetry..."

  if [[ -n "$(command -c poetry)" ]]; then
    warning "Already installed. Updating..."
    poetry self update

    success
    return
  fi

  curl -sSL https://install.python-poetry.org | python - 1>/dev/null

  if [[ $? -ne 0 ]]; then
    error "Failed to install poetry"
    return
  fi

  header "Installing poetry export plugin..."
  poetry self add poetry-plugin-export

  success
}

symlink_poetry() {
  header "Symlink poetry config.toml"
  symlink "$DOTFILES_HOME"/poetry.toml "$XDG_CONFIG_HOME"/pypoetry/config.toml
}

main() {
  install_deps
  setup_env
  install_python_tools
  # symlink_configs
  # install_poetry
  # symlink_poetry
}

main
