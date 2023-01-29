#
# .zshenv - Zsh environment file, loaded always.
#
# NOTE: .zshenv has to live at ~/.zshenv, not in $ZDOTDIR! You can get around this by
# symlinking .zshenv from your $ZDOTDIR: `ln -sf $ZDOTDIR/.zshenv ~/.zshenv`
#

#
# ZDOTDIR
#

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
export ZDOTDIR=${ZDOTDIR:-${XDG_CONFIG_HOME}/zsh}

#
# .zprofile
#

# We use .zprofile for everything else (load for non-login, non-interactive shells).
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# vim: ft=zsh sw=2 ts=2 et
