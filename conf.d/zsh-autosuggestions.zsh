#!/bin/zsh
# https://github.com/zsh-users/zsh-autosuggestions

[[ -n "$ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE" ]] || return 1

# Set highlight color, default 'fg=8'.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# Set key bindings.
if [[ -n "$key_info" ]]; then
  # vi
  bindkey -M viins "$key_info[Control]F" vi-forward-word
  bindkey -M viins "$key_info[Control]E" vi-add-eol
fi
