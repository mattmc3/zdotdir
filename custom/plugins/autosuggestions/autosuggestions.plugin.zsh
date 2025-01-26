repodir="$ZSH_CUSTOM/.external/zsh-autosuggestions"
if [[ ! -d "$repodir" ]]; then
  git clone --quiet --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$repodir"
fi
source $repodir/zsh-autosuggestions.plugin.zsh
unset repodir

# Set highlight color, default 'fg=8'.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# Set key bindings.
if [[ -n "$key_info" ]]; then
  # vi
  bindkey -M viins "$key_info[Control]F" vi-forward-word
  bindkey -M viins "$key_info[Control]E" vi-add-eol
fi
