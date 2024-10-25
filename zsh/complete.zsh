
# # .... path completion
# __expand_dots() {
#     # add / after sequence of ......, if not there
#     local cur=`echo "$1" | sed 's/\( \|^\)\(\.\.\.\.*\)\([^\/\.]\|$\)/\1\2\/\3/g'`
#     while true; do  # loop to expand ...
#         local new=`echo $cur | sed 's/\.\.\./\.\.\/\.\./g'`
#         if [[ $new == $cur ]]; then
#             break
#         fi
#         cur=$new
#     done
#     BUFFER=$cur
# }

# __user_complete(){
#     # In the context of zsh and its line editor (zle)
#     # $BUFFER is a special variable that holds the current contents of the command line.
#     # This includes whatever the user has typed before pressing a key bound to a custom function or widget.
#     if [[ -z $BUFFER ]]; then
#         return
#     fi
#     if [[ $BUFFER =~ "^\.\.\.*$" ]]; then
#         __expand_dots "$BUFFER"
#         zle end-of-line
#         return
#     elif [[ $BUFFER =~ ".* \.\.\..*$" ]] ;then
#         __expand_dots "$BUFFER"
#         zle end-of-line
#         return
#     fi
#     # zle expand-or-complete
#     zle fzf-tab-complete
# }

# zle -N __user_complete
# bindkey "\t" __user_complete  # bind tab
# autoload compinstall  # lazy load zsh's completion system

# file completion ignore
zstyle ':completion:*:*:*vim:*:*files' ignored-patterns '*.(avi|mkv|rmvb|pyc|wmv|mp3|mp4|pdf|doc|docx|jpg|png|bmp|gif|npy|bin|o)'
zstyle ':completion:*:*:*v:*:*files' ignored-patterns '*.(avi|mkv|rmvb|pyc|wmv|mp3|pdf|doc|docx|jpg|png|bmp|gif|npy|bin|o)'  # alias v=vim

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

zstyle ':omz:plugins:docker' legacy-completion yes