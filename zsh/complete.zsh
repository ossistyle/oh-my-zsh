
# # only for git
# zstyle ':completion:*:*:git:*' fzf-search-display true

# # basic file preview for ls (you can replace with something more sophisticated than head)
# zstyle ':completion::*:ls::*' fzf-completion-opts --preview='eval head {1}'

# # preview when completing env vars (note: only works for exported variables)
# # eval twice, first to unescape the string, second to expand the $variable
# zstyle ':completion::*:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-completion-opts --preview='eval eval echo {1}'

# # preview a `git status` when completing git add
# zstyle ':completion::*:git::git,add,*' fzf-completion-opts --preview='git -c color.status=always status --short'

# # if other subcommand to git is given, show a git diff or git log
# zstyle ':completion::*:git::*,[a-z]*' fzf-completion-opts --preview='
# eval set -- {+1}
# for arg in "$@"; do
#     { git diff --color=always -- "$arg" | git log --color=always "$arg" } 2>/dev/null
# done'

# # # disable sort when completing `git checkout`
# zstyle ':completion:*:git-checkout:*' sort false
# # # set descriptions format to enable group support
# # # NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
# zstyle ':completion:*:descriptions' format '[%d]'
# # # set list-colors to enable filename colorizing
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# # # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
# zstyle ':completion:*' menu no
# # # preview directory's content with eza when completing cd
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# # # custom fzf flags
# # # NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
# zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# # # To make fzf-tab follow FZF_DEFAULT_OPTS.
# # # NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
# zstyle ':fzf-tab:*' use-fzf-default-opts yes
# # # switch group using `<` and `>`
# zstyle ':fzf-tab:*' switch-group '<' '>'

# zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza -1 --color=always $realpath'

# zstyle ':omz:plugins:docker' legacy-completion yes

# export FZF_DEFAULT_OPTS='--bind ctrl-d:page-down,ctrl-u:page-up --height 60%'  # like vim
export FZF_DEFAULT_OPTS="\
  --marker='❯' \
  --pointer='❯' \
  --prompt='❯ ' \
  --scrollbar='│' \
  --cycle \
  --layout='reverse' \
  --info='right' \
  --bind='ctrl-d:page-down' \
  --bind='ctrl-u:page-up' \
  --preview-window='right:50%,wrap' \
  --height='100%'"

LESSOPEN='|$HOME/.zsh/functions/less_filter.sh %s'
export LESSOPEN

export FZF_COMPLETION_OPTS=" --cycle \
    --ansi \
    --walker-skip='.git,node_modules' \
    --walker='file,dir,follow,hidden'"

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

export FZF_COMPLETION_TRIGGER='~~'

# options to fzf command
zstyle ':fzf-tab:complete:z:*' fzf-preview 'less ${(Q)realpath}'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'less ${(Q)realpath}'
# zstyle ':fzf-tab:complete:eza:*' fzf-preview 'less ${(Q)realpath}'
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' switch-group 'Left' 'Right'
zstyle ":fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*" fzf-flags "--preview-window=wrap" "${FZF_TAB_DEFAULT_FZF_FLAGS[@]}"
zstyle ":fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*" fzf-preview "[[ -n \${(P)word} ]] && echo \${(P)word} || echo \<unset\>"

# default fzf settings to apply globally
FZF_TAB_DEFAULT_FZF_FLAGS=(
  "--height=90%"
)
zstyle ":fzf-tab:*" fzf-flags "${FZF_TAB_DEFAULT_FZF_FLAGS[@]}"

# autosuggest config
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)

# docker completion config
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# eza config
zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'git-status' yes
zstyle ':omz:plugins:eza' 'header' yes
zstyle ':omz:plugins:eza' 'show-group' yes
zstyle ':omz:plugins:eza' 'icons' no
zstyle ':omz:plugins:eza' 'size-prefix' si