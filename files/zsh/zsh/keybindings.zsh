
# default beginning-of-line is ctrl-a, which conflicted with keybinding ctrl-a
# used in tmux. 
# bindkey -r "^D"
# _exit_zsh_if_empty() {
#   if [[ -z $BUFFER ]]; then exit; fi
# }
# zle -N _exit_zsh_if_empty
# bindkey '^D' _exit_zsh_if_empty

# navigate words
# ctrl + a/e for beginning/end of line
# ctrl + p/n for previous/next command
# ctrl + m for enter
# ctrl + k for kill line
# bindkey '^F' forward-word
# bindkey '^B' backward-word
# bindkey '^H' backward-char
# bindkey '^L' forward-char
# bindkey '^?' backward-delete-char
# bindkey "^X^X" backward-delete-char

# # plugins
# autoload -Uz jump-target
# zle -N jump-target
# bindkey "^J" jump-target  # using ctrl+j to jump to target character

# # FZF Configuration
# # Use ~~ as the trigger sequence instead of the default **
# export FZF_COMPLETION_TRIGGER=''

# # Options to fzf command
# export FZF_COMPLETION_OPTS='--border --info=inline'

# # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# # - The first argument to the function ($1) is the base path to start traversal
# # - See the source code (completion.{bash,zsh}) for the details.
# _fzf_compgen_path() {
#   fdfind --hidden --follow --exclude ".git" . "$1"
# }

# # Use fd to generate the list for directory completion
# _fzf_compgen_dir() {
#   fdfind --type d --hidden --follow --exclude ".git" . "$1"
# }

# # Advanced customization of fzf options via _fzf_comprun function
# # - The first argument to the function is the name of the command.
# # - You should make sure to pass the rest of the arguments to fzf.
# _fzf_comprun() {
#   local command=$1
#   shift

#   case "$command" in
#     cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
#     export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
#     ssh)          fzf --preview 'dig {}'                   "$@" ;;
#     *)            fzf --preview 'batcat -n --color=always {}' "$@" ;;
#   esac
# }