
source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundles <<EOBUNDLES
    git
    docker
    docker-compose
    Aloxaf/fzf-tab
    unixorn/fzf-zsh-plugin@main
    zsh-eza
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-autosuggestions
    # zsh-users/zsh-completions    
    junegunn/fzf
EOBUNDLES

# Load the theme.
antigen theme romkatv/powerlevel10k

# Tell Antigen that you're done.
antigen apply 
