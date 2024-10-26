
install_fd() {
    os_install fd-find
    ln -sf "$(command -v fdfind)" "$HOME"/.local/bin/fd
}

main() {
    install_fd
}

main