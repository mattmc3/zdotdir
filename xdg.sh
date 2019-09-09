# https://wiki.archlinux.org/index.php/XDG_Base_Directory

# Set XDG dirs are set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME/.xdg}"

[[ -z $XDG_BASEDIRS_SET ]] || return

# set variable that lets us know about whether this has run
export XDG_BASEDIRS_SET=true

function xdg_dupe_check() {
  if [[ -e "$1" ]] && [[ -e "$2" ]]; then
    echo "XDG split-brain dupes detected:\n${1}\n${2}"
  fi
}

#
# less
#
mkdir -p "$XDG_CACHE_HOME"/less
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
xdg_dupe_check $LESSHISTFILE ~/.lesshst

#
# readline
#
[[ -f "$XDG_CONFIG_HOME"/readline/inputrc ]] && export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
xdg_dupe_check $INPUTRC ~/.inputrc

#
# todo.sh (todo.txt)
#
[[ -f "$XDG_CONFIG_HOME"/todo-txt/config ]] && export TODOTXT_CFG_FILE="$XDG_CONFIG_HOME"/todo-txt/config
xdg_dupe_check $TODOTXT_CFG_FILE ~/.todo/config

#
# z
#
[[ -f "$XDG_DATA_HOME"/z/data ]] && export _Z_DATA="$XDG_DATA_HOME"/z/data
xdg_dupe_check $_Z_DATA ~/.z
