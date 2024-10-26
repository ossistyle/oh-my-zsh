install_btop() {
    header "Installing btop ..."

    clone aristocratos/btop "$HOME"
    [[ $? -ne 0 ]] && exit

    info "Building neovim from source..."

    git checkout master

    cd "$HOME"/btop || exit
    sudo make install

}
