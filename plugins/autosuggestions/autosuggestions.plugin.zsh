#
# autosuggestions - Fish-like Zsh autosuggestions
#

plugin-load zsh-users/zsh-autosuggestions

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
if [[ -n "$key_info" ]]; then
  # vi
  bindkey -M viins "$key_info[Control]F" vi-forward-word
  bindkey -M viins "$key_info[Control]E" vi-add-eol
fi
