# set plugin variables here
export _Z_DATA="$XDG_DATA_HOME/z/data"

#
# antibody is an option if you want it
#
# source <(antibody init)
# antibody bundle < $ZDOTDIR/zsh_plugins

# set plugin vars here
# omz
ZSH=$ZDOTDIR/plugins/oh-my-zsh
#ZSH_THEME=avit

function _plugins {
  # read non-comment plugins into array
  [[ -f "$ZDOTDIR"/zsh_plugins ]] || touch "$ZDOTDIR"/zsh_plugins
  #local plugins=($(sed -n '/^[^#]/p' "$ZDOTDIR"/zsh_plugins))
  local plugins=(
    rupa/z
    zdharma/fast-syntax-highlighting
  )

  # get plugins if we don't already have them
  for p in $plugins; do
    plugin_name="${p##*/}"
    plugin_dir="${ZDOTDIR}"/plugins/$plugin_name

    if [[ ! -d "$plugin_dir" ]]; then
      echo "cloning plugin repo: $p"
      git clone --recursive "https://github.com/${p}.git" "$plugin_dir"
    fi
    for ext in '.plugin.zsh' '.zsh' '.sh' '.zsh-theme'; do
      if [[ -f "$plugin_dir/${plugin_name}${ext}" ]]; then
        source "$plugin_dir/${plugin_name}${ext}"
        break
      fi
    done
  done
}
_plugins
unfunction _plugins

# unset bad plugin settings here
# ...
