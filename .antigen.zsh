# Install Antigen
if [[ ! -a ~/.antigen/antigen.zsh ]]; then
    git clone --branch master git@github.com:zsh-users/antigen.git ~/.antigen
    # @see https://github.com/zsh-users/antigen/issues/583
    cd ~/.antigen 
    git checkout v2.2.3 
    cd -
fi

source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundles <<EOBUNDLES
    git
    docker
    docker-compose
    zsh-eza
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-completions
    #Aloxaf/fzf-tab
    #unixorn/fzf-zsh-plugin@main
    #junegunn/fzf
EOBUNDLES

# Load the theme.
antigen theme romkatv/powerlevel10k

# Tell Antigen that you're done.
antigen apply