#!/bin/env bash

source scripts/helper.sh

install_zsh () {
  header "Installing zsh..."
  os_install zsh
}

install_plugins () {
  header "Installing zsh plugins..."

  PLUGINS_DIR=$XDG_DATA_HOME/zsh/plugins
  THEMES_DIR=$XDG_DATA_HOME/zsh/themes

  plugins=(
    zsh-users/zsh-completions
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-autosuggestions
    Aloxaf/fzf-tab
  )

  themes=(
    romkatv/powerlevel10k
  )

  for plugin in ${plugins[@]}; do
    clone $plugin $PLUGINS_DIR
  done

  for theme in ${themes[@]}; do
    clone $theme $THEMES_DIR
  done
}

install_nerd_fonts() {
    header "Install nerd fonts"

    fonts_dir="$HOME/.local/share/fonts"

    if [[ ! -d "$fonts_dir" ]]; then
        mkdir -p "$fonts_dir"
    fi

    clone ryanoasis/nerd-fonts "$HOME" 
    git checkout master   
    cd $HOME/nerd-fonts && git checkout master && ./install.sh Meslo || exit
    
    fc-cache -fv

    success
}

install_symlinks () {
  header "Symlink .zshrc and ZDOTDIR"

  [[ ! -d $HOME/.config ]] && mkdir $HOME/.config
  symlink $DOTFILES_HOME/zsh/.zshenv $HOME/.zshenv
  # symlink $DOTFILES_HOME/zsh/.zshrc $HOME/.zshrc  
  symlink $DOTFILES_HOME/zsh $HOME/.config/zsh

  success
}

setup_user_shell () {
  header "Setting shell"

  sudo chsh -s "$(command -v zsh)" $(whoami)

  success
}

main () {
  install_zsh
  install_plugins
  # install_nerd_fonts
  install_symlinks
  setup_user_shell
}

main