# Setup fzf
# ---------
if [[ ! "$PATH" == */home/thomashoffmann/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/thomashoffmann/.fzf/bin"
fi

source <(fzf --zsh)
