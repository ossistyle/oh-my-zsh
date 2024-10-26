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
  header "Symlink .zshenv and ZDOTDIR"

  [[ ! -d $HOME/.config ]] && mkdir $HOME/.config
  symlink $DOTFILES_HOME/zsh/.zshenv $HOME/.zshenv
  symlink $DOTFILES_HOME/zsh $HOME/.config/zsh

  success
}

setup_user_shell () {
  header "Setting shell"

  sudo chsh -s $(which zsh) $(whoami)

  success
}

main () {
  install_zsh
  install_plugins
  install_nerd_fonts
  install_symlinks
  setup_user_shell
}

main

# prepare_zsh() {
#     os_install zsh
#     install_ohmyzsh
#     cp zshrc "$HOME"/.zshrc
#     cp -r "$DOTFILES_HOME"/zsh "$HOME"/.zsh
#     # cp antigen.zsh $HOME/.antigen.zsh
#     install_zsh_plugins
#     install_zsh_theme
#     sudo chsh "$USER" -s /usr/bin/zsh
# }

# download_font() {
#     fonts_dir="$HOME/.local/share/fonts"

#     if [[ ! -d "$fonts_dir" ]]; then
#         mkdir -p "$fonts_dir"
#     fi

#     for font in "$@"; do
#         zip_file="$font.zip"
#         download_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$zip_file"
#         echo "Downloading $download_url"
#         wget -O "/tmp/$zip_file" "$download_url"
#         unzip "/tmp/$zip_file" -d "/tmp/$font/"
#         mv /tmp/"$font"/*.ttf "$fonts_dir"
#         rm "/tmp/$zip_file"
#         rm "/tmp/$font/" -rf
#     done

#     fc-cache -fv
# }

# install_zsh_plugins() {
#     git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
#     git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
#     git clone https://github.com/Aloxaf/fzf-tab "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/fzf-tab
# }

# install_zsh_theme() {
#     git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
# }

# prepare_local() {
#     if [ ! -d "$HOME/.local/bin" ]; then
#         mkdir "$HOME"/.local/bin
#     fi
# }

# install_antigen() {
#     if [[ ! -e ~/.antigen/antigen.zsh ]]; then
#         git clone --branch master git@github.com:zsh-users/antigen.git ~/.antigen
#         # @see https://github.com/zsh-users/antigen/issues/583
#         cd ~/.antigen || exit
#         git checkout v2.2.3
#         cd ~ || exit
#     fi
# }

# install_zoxide() {
#     if [ ! -x "$(command -v zoxide)" ]; then
#         curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
#     fi
# }

# install_eza() {
#     os_install gpg
#     sudo mkdir -p /etc/apt/keyrings
#     sudo rm -f /etc/apt/keyrings/gierens.gpg
#     wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
#     echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
#     sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
#     sudo apt update
#     os_install eza
# }

# install_ohmyzsh() {
#     sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# }

# install_fzf() {
#     make fzf    
# }

# install_fd() {
#     os_install fd-find
#     ln -sf "$(command -v fdfind)" "$HOME"/.local/bin/fd
# }

# omz_complete() {
#     cp "$ZSH/plugins/docker/completions/_docker" "$ZSH_CACHE_DIR/completions"
# }

# install_zsh_tools() {
#     os_install tree
#     os_install btop
#     os_install bat
#     os_install ripgrep
#     os_install pkgconf
#     os_install fontconfig
#     os_install unzip

#     download_font meslo

#     install_fd
#     install_zoxide
#     install_eza
#     install_fzf
# }

# update_zsh_conf() {
#     # if ! [ -f "tmux.conf" ]; then
#     #     echo "update_conf should be executed under the dofile dir."
#     #     return
#     # fi
#     # cp tmux.conf $HOME/.tmux.conf
#     header "Setting up neovim..."

#     if [ -d "$HOME"/.zsh ]; then
#         info "remove $HOME/.zsh dir"
#         rm -rf "$HOME"/.zsh
#     fi
#     info "update $HOME/.zsh dir"
#     cp zshrc "$HOME"/.zshrc
#     info "update ~/.zsh file"
#     cp -r "$DOTFILES_HOME"/zsh "$HOME"/.zsh

#     if ! [ -f "$HOME/.zsh.local" ]; then
#         info "update $HOME/.zsh.local, for local usage"
#         cp zsh.local "$HOME"/.zsh.local
#     fi
#     success

#     # echo "update $HOME/.python_startup.py, for python startup"
#     # cp python/startup.py $HOME/.python_startup.py
# }

# install_all() {
#     prepare_local
#     prepare_zsh
#     install_zsh_tools

#     rm -f ~/.zcompdump
#     compinit # clear zsh completion cache
# }

# main() {
#     install_all
# }

# main
