# some utilities

# ==== Settings ====
export ZSH_DISABLE_COMPFIX=true

# Disable CTRL-s from freezing your terminal's output.
stty stop undef

# Disable highlighting of pasted text
zle_highlight=('paste:none')

# ==== Options ====
# Enable in-line comments
setopt INTERACTIVE_COMMENTS

# ==== Plugins ====
safe_source $ZDOTDIR/utils.zsh

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf-tab
    docker
    docker-compose
    eza
)

for plugin in ${plugins[@]}; do
  add_plugin $plugin
done

# ==== Addons ====
addons=(
    base
    git
    alias
    keybindings
    complete  
)

for addon in ${addons[@]}; do
  safe_source $addon.zsh
done

# ==== Theme ====
ZSH_THEME=powerlevel10k
P10K_THEME=lean
# P10K_THEME=rainbow

load_theme $ZSH_THEME

for file in $HOME/.zsh/*.zsh; do
    source $file
done


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
safe_source p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# export zsh is important
export ZSH="$HOME/.oh-my-zsh"

# zsh config
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

setopt complete_aliases  # enable alias completion

#LESSOPEN="|/usr/local/bin/lesspipe.sh %s"; 
#export LESSOPEN

# zsh history settings
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=80000
setopt INC_APPEND_HISTORY    # append history as soon as the command is executed
setopt HIST_IGNORE_DUPS      # don't record an entry that was just recorded again
setopt HIST_IGNORE_SPACE     # don't save commands that start with a space
setopt HIST_FIND_NO_DUPS     # don't display duplicates in history search
setopt HIST_NO_FUNCTIONS     # don't save function definitions in the history file
setopt SHARE_HISTORY         # share history between all sessions
unsetopt EXTENDED_HISTORY    # disable the extended history format that includes timestamp information for each command

# Load fastfetch
#if [[ -o interactive ]]; then
#     fastfetch
#fi

# alias and self defined function
safe_export_path $HOME/.local/bin >/dev/null
safe_source $ZSH/oh-my-zsh.sh



safe_add_fpath "$HOME/.zsh/Completion"
safe_add_fpath "$HOME/.zsh/functions"
safe_add_fpath "$HOME/bin"
safe_add_fpath "$HOME/.local/bin"
safe_add_fpath "/usr/local/bin"

safe_source "$HOME"/.fzf.zsh
safe_source "$HOME"/.zsh.local  # local file is used to store local configuration




