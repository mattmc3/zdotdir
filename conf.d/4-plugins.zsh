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
  if [[ ! -f "$ZDOTDIR"/zsh_plugins ]]; then
    echo "zsh_plugins=()" > "$ZDOTDIR"/zsh_plugins
  fi
  source "$ZDOTDIR"/zsh_plugins

  # get plugins if we don't already have them
  for p in $zsh_plugins; do
    zshplug load "$p"
  done
}
_plugins
unfunction _plugins

# unset bad plugin settings here
# ...
