# ======== Tools ========
# Disable tmupx autotitle
export DISABLE_AUTO_TITLE=true

# snaps
[[ -d /snap/bin && ! $PATH == */snap/bin* ]] && export PATH=$PATH:/snap/bin



# fzf
if [[ -f $HOME/.fzf.zsh ]]; then
  source $HOME/.fzf.zsh
echo "foo"
  FD_OPTIONS="--hidden --follow --exclude .git"
  export FZF_DEFAULT_COMMAND="fdfind --type f --type l $FD_OPTIONS"
  export FZF_DEFAULT_OPTS="\
    --multi \
    --height=80% \
    --border=sharp \
    --preview='tree -C {}' \
    --preview-window='45%,border-sharp' \
    --prompt='Dirs > ' \
    --bind='del:execute(rm -ri {+})' \
    --bind='ctrl-p:toggle-preview' \
    --bind='ctrl-d:change-prompt(Dirs > )' \
    --bind='ctrl-d:+reload(find -type d)' \
    --bind='ctrl-d:+change-preview(tree -C {})' \
    --bind='ctrl-d:+refresh-preview' \
    --bind='ctrl-f:change-prompt(Files > )' \
    --bind='ctrl-f:+reload(find -type f)' \
    --bind='ctrl-f:+change-preview(batcat {})' \
    --bind='ctrl-f:+refresh-preview' \
    --bind='ctrl-a:select-all' \
    --bind='ctrl-x:deselect-all' \
    --header '
CTRL-D to display directories | CTRL-F to display files
CTRL-A to select all | CTRL-x to deselect all
ENTER to edit | DEL to delete
CTRL-P to toggle preview
'"

  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  bindkey '^f' fzf-cd-widget
fi