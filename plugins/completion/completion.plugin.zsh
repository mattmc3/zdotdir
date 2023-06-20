#
# completion - Set up zsh completions
#

plugin-load zsh-users/zsh-completions

fpath=(
  # add curl completions from homebrew if they exist
  /{usr,opt}/{local,homebrew}/opt/curl/share/zsh/site-functions(-/FN)

  # add zsh completions
  /{usr,opt}/{local,homebrew}/share/zsh/site-functions(-/FN)

  # Allow custom user completions.
  ${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/completions(-/FN)
  ${ZSH_CUSTOM:-$ZDOTDIR/custom}/completions(-/FN)

  # the rest of fpath
  $fpath
)

# Prezto forces this file for completions - don't try to change it. It won't work.
: ${ZSH_COMPDUMP:=${XDG_CACHE_HOME:-$HOME/.cache}/prezto/zcompdump}

# Load prezto completions
plugin-load sorin-ionescu/prezto/modules/completion
