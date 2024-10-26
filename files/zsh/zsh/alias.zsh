
# global aliases
# alias -g L="| less"
# alias -g JL="| jq | less"
# alias -g CL="| pygmentize | less"
# alias -g X="| xargs"
# alias -g B='|sed -r "s:\x1B\[[0-9;]*[mK]::g"'       # remove color, make things boring
# alias -g N='>/dev/null'
# alias -g NN='>/dev/null 2>&1'
# alias -g F="| fzf"
# alias -g H="--help"

# file
alias 'rm!'="rm -rf"
alias rm="rm -r"
alias cp="cp -r"
alias sv="sudo vim"
alias vi="vim"
alias v="vim"
alias c="clear"
# zoxide config
# alias cd="z"
alias cat="batcat"
alias bat="batcat"
alias icat="imgcat"
alias rp="realpath"
alias rf="readlink -f"
alias findname="find . -name"
alias latest='ls -lt | head -n 2 | awk '\''NR==2{print $NF}'\'

alias nohistory='unset HISTFILE'

# alias ls='eza $eza_params'
# alias l='eza --git-ignore $eza_params'
# alias ll='eza --all --header --long $eza_params'
# alias llm='eza --all --header --long --sort=modified $eza_params'
# alias la='eza -lbhHigUmuSa'
# alias lx='eza -lbhHigUmuSa@'
# alias lt='eza --tree $eza_params'
# alias tree='eza --tree $eza_params'

## diff dir a and b, run `diffdir a b DIFF`
alias diffdir="diff --exclude '*.txt' --exclude '*.pkl' --exclude '*__pycache__*'"
alias -g DIFF='--width="$COLUMNS" --suppress-common-lines --side-by-side --recursive'

## tar aliases
alias tarinfo="tar -tf"
alias tarzip="tar -zcvf"
alias tarunzip="tar -zxvf"

# system
alias cn_tz="TZ=Europe/Berlin date"  # cn time zone
alias zh_cn="LC_ALL='en_US.UTF-8'"  # encode
alias cursor="echo -e '\033[?25h'"
alias which="which -a"
alias m="make"
alias font="fc-list :lang=de"

## pretty print the $PATH
alias path='echo $PATH | tr -s ":" "\n"'
alias pck='export PATH_CKPT="$(pwd)"'
alias jck='cd "$PATH_CKPT"'
alias search_alias='alias | grep'

## alternatives
alias alter_conf="sudo update-alternatives --config"
alias alter_install="sudo update-alternatives --install"

# process
## for example, to kill process with python, run `pshow python KILL`
alias pshow="ps -ef | grep"
alias psfzf="ps -ef | fzf --bind 'ctrl-r:reload(ps -ef)' \
      --header 'Press CTRL-R to reload' --header-lines=1 \
      --height=50% --layout=reverse"
alias -g KILL="| awk '{print \$2}' | head -n 1 | xargs kill -9"

# sync
alias scp="scp -r"
alias rsync="rsync -avP"

# python
alias ip3="python3 -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
alias pip3="python3 -m pip "
alias pip="python -m pip "
alias pip_tuna="pip install -i https://pypi.tuna.tsinghua.edu.cn/simple"
alias pip_ins="pip install -v -e ."
alias pdbtest="pytest --pdb --pdbcls=IPython.terminal.debugger:Pdb -s"
alias nb2py="jupyter nbconvert --to script"

# git aliases, see https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git for more
alias gmm="git commit --amend"  # git message modification
alias gad='git add $(git ls-files --deleted)'
alias grt='cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)"'  # override
alias gcf_mir='git config --global url."https://gitclone.com/".insteadOf https://'
alias gcf_rst_mir='git config --global --unset url.https://gitclone.com/.insteadOf'
alias git_ls_unreachable='git fsck --unreachable --no-reflog'

