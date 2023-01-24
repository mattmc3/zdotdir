export ZDOTDIR=${ZDOTDIR:-~/.zsh}

export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_RUNTIME_DIR=~/.xdg

# non-login, non-interactive shells should also have a defined environment
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s $ZDOTDIR/.zprofile ]]; then
  . $ZDOTDIR/.zprofile
fi

# vim: ft=zsh
