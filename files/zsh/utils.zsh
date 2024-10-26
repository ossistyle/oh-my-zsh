add_plugin() {
  if [[ ! -d $XDG_DATA_HOME/zsh/plugins/$1 ]]; then
    echo -e "\e[93m \e[97mPlugin $1 does not exist"
    return
  fi

  source $XDG_DATA_HOME/zsh/plugins/$1/$1.plugin.zsh
}

load_theme() {
  if [[ ! -d $XDG_DATA_HOME/zsh/themes/$1 ]]; then
    echo -e "\e[93m \e[97mTheme $1 does not exist"
    return
  fi

  source $XDG_DATA_HOME/zsh/themes/$1/$1.zsh-theme
}

function safe_source() { [ -f  "$1" ] && source "$1" }
# function safe_export_path() { [[ -d $1 ]] && export PATH=$1:$PATH }
function safe_add_fpath() { [[ -d "$1" ]] && fpath=("$1" $fpath) }  # NOTE: don't quote fpath here
function safe_export_path() {
    if [[ -d "$1" ]]; then
        if [[ ":$PATH:" == *":$1:"* ]]; then
            echo "$1 already exists in PATH"
        else
            export PATH="$1:$PATH"
        fi
    fi
}