#!/bin/env bash

source scripts/helper.sh

install_btop() {
    header "Installing btop ..."

    # local ver=1.4.0
    # #clone aristocratos/btop "$HOME"
    # #[[ $? -ne 0 ]] && exit
    # download https://github.com/aristocratos/btop/archive/refs/tags/v$ver.tar.gz "$HOME"

    # tar xvf "$HOME"/v"$ver".tar.gz -C "$HOME"

    # info "Building btop from source..."

    # cd "$HOME"/btop-"$ver" && sudo make install || exit
    sudo snap install btop
    
}

main() {
    install_btop
}

main
