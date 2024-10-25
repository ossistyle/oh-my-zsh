
os_install()
{
    local package_name=$1
    if [ "$OS_DISTRIBUTION" = "macos" ]; then
        brew install $package_name
    elif [ "$OS_DISTRIBUTION" = "ubuntu" ]; then
        sudo apt update
        sudo apt-get install -y $package_name
    fi
}

prepare_zsh()
{
    os_install zsh
    install_ohmyzsh
    cp zshrc $HOME/.zshrc
    cp -r zsh $HOME/.zsh
    sudo chsh "$USER" -s /usr/bin/zsh
}

install_antigen()
{
if [[ ! -a ~/.antigen/antigen.zsh ]]; then
    git clone --branch master git@github.com:zsh-users/antigen.git ~/.antigen
    # @see https://github.com/zsh-users/antigen/issues/583
    cd ~/.antigen 
    git checkout v2.2.3 
    cd ~
fi
}

install_eza()
{
	sudo apt install -y gpg
	sudo mkdir -p /etc/apt/keyrings
	wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
	echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
	sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
	sudo apt update
	os_install -y eza
}

install_ohmyzsh()
{
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    install_antigen
}

install_miniconda()
{
    if [[ "$(uname)" == "Darwin" ]]; then  # macOS
        mkdir -p $HOME/miniconda3
        curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o $HOME/miniconda3/miniconda.sh
        bash $HOME/miniconda3/miniconda.sh -b -u -p $HOME/miniconda3
        rm -rf $HOME/miniconda3/miniconda.sh~
    elif [[ "$(uname)" == "Linux" ]]; then  # Linux
        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $HOME/miniconda.sh
        bash $HOME/miniconda.sh -b -p $HOME/miniconda
        rm $HOME/miniconda.sh
    fi
    $HOME/miniconda3/bin/conda init zsh
}

install_fzf()
{
    if [ -d "$HOME/.fzf" ]; then
        echo "fzf already installed"
    else
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        $HOME/.fzf/install
    fi
}

install_fd()
{
    if [ "$OS_DISTRIBUTION" = "macos" ]; then
        brew install fd
    elif [ "$OS_DISTRIBUTION" = "ubuntu" ]; then
        sudo apt install -y fd-find
        ln -s $(which fdfind) $HOME/.local/bin/fd
    fi
}
omz_complete()
{
    cp "$ZSH/plugins/docker/completions/_docker" "$ZSH_CACHE_DIR/completions"
    cp "$HOME/.zsh/Completion/_conda" "$ZSH_CACHE_DIR/completions"
}

install_tools()
{
    os_install tree
    os_install btop
    os_install bat
    os_install shellcheck
    os_install python3
    os_install ripgrep

    install_fzf
}

install_all()
{
    prepare_zsh	
    install_eza
	install_tools	
}

update_conf()
{
    if ! [ -f "tmux.conf" ]; then
        echo "update_conf should be executed under the dofile dir."
        return
    fi
    cp tmux.conf $HOME/.tmux.conf
    if [ -d $HOME/.zsh ]; then
        echo "remove ~/.zsh dir"
        rm -rf $HOME/.zsh
    fi
    cp zshrc $HOME/.zshrc
    cp -r zsh $HOME/.zsh

    if ! [ -f "$HOME/.zsh.local" ]; then
        echo "update zsh.local, for local usage"
        cp zsh.local $HOME/.zsh.local
    fi
    echo "update configure of zsh & tmux done"

    echo "update $HOME/.python_startup.py, for python startup"
    cp python/startup.py $HOME/.python_startup.py
}
