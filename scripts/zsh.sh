#!/bin/env bash

. ./helper.sh

prepare_zsh() {
    os_install zsh
    install_ohmyzsh
    cp zshrc "$HOME"/.zshrc
    cp -r zsh "$HOME"/.zsh
    # cp antigen.zsh $HOME/.antigen.zsh
    install_zsh_plugins
    install_zsh_theme
    sudo chsh "$USER" -s /usr/bin/zsh
}

download_font() {
    fonts_dir="$HOME/.local/share/fonts"

    if [[ ! -d "$fonts_dir" ]]; then
        mkdir -p "$fonts_dir"
    fi

    for font in "$@"; do
        zip_file="$font.zip"
        download_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$zip_file"
        echo "Downloading $download_url"
        wget -O "/tmp/$zip_file" "$download_url"
        unzip "/tmp/$zip_file" -d "/tmp/$font/"
        mv /tmp/"$font"/*.ttf "$fonts_dir"
        rm "/tmp/$zip_file"
        rm "/tmp/$font/" -rf
    done

    fc-cache -fv
}

install_zsh_plugins() {
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
    git clone https://github.com/Aloxaf/fzf-tab "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/fzf-tab
}

install_zsh_theme() {
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
}

prepare_local() {
    if [ ! -d "$HOME/.local/bin" ]; then
        mkdir "$HOME"/.local/bin
    fi
}

install_antigen() {
    if [[ ! -e ~/.antigen/antigen.zsh ]]; then
        git clone --branch master git@github.com:zsh-users/antigen.git ~/.antigen
        # @see https://github.com/zsh-users/antigen/issues/583
        cd ~/.antigen || exit
        git checkout v2.2.3
        cd ~ || exit
    fi
}

install_zoxide() {
    if [ ! -x "$(command -v zoxide)" ]; then
        curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    fi
}

install_eza() {
    sudo apt install -y gpg
    sudo mkdir -p /etc/apt/keyrings
    sudo rm -f /etc/apt/keyrings/gierens.gpg
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    os_install -y eza
}

install_ohmyzsh() {
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_fzf() {
    if [ -d "$HOME/.fzf" ]; then
        echo "fzf already installed"
    else
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        "$HOME"/.fzf/install
    fi
}

install_fd() {
    os_install fd-find
    ln -sf "$(command -v fdfind)" "$HOME"/.local/bin/fd
}

omz_complete() {
    cp "$ZSH/plugins/docker/completions/_docker" "$ZSH_CACHE_DIR/completions"
}

install_zsh_tools() {
    os_install tree
    os_install btop
    os_install bat
    os_install python3
    os_install ripgrep
    os_install pkgconf
    os_install fontconfig
    os_install unzip

    # neovim deps
    install_neovim_deps

    download_font meslo

    install_neovim
    install_fd
    install_zoxide
    install_eza
    install_fzf
}

update_zsh_conf() {
    # if ! [ -f "tmux.conf" ]; then
    #     echo "update_conf should be executed under the dofile dir."
    #     return
    # fi
    # cp tmux.conf $HOME/.tmux.conf
    header "Setting up neovim..."

    if [ -d "$HOME"/.zsh ]; then
        echo "remove ~/.zsh dir"
        rm -rf "$HOME"/.zsh
    fi
    info "update ~/.zsh dir"
    cp zshrc "$HOME"/.zshrc
    info "update ~/.zsh file"
    cp -r zsh "$HOME"/.zsh

    if ! [ -f "$HOME/.zsh.local" ]; then
        info "update zsh.local, for local usage"
        cp zsh.local "$HOME"/.zsh.local
    fi
    success

    # echo "update $HOME/.python_startup.py, for python startup"
    # cp python/startup.py $HOME/.python_startup.py
}

install_all() {
    prepare_local
    prepare_zsh
    install_zsh_tools

    rm -f ~/.zcompdump
    compinit # clear zsh completion cache
}

main() {
    install_all
}

main
