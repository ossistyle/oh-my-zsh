#!/bin/env bash

source scripts/helper.sh

install_eza() {
    header "Install eza"

    os_install gpg
    sudo mkdir -p /etc/apt/keyrings
    sudo rm -f /etc/apt/keyrings/gierens.gpg
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    os_install eza

    success
}