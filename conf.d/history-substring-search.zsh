for keymap in 'emacs' 'viins'; do
  if [[ "$OSTYPE" == darwin* ]]; then
    bindkey -M "$keymap" '^[[A' history-substring-search-up
    bindkey -M "$keymap" '^[[B' history-substring-search-down
  else
    bindkey -M "$keymap" "$terminfo[kcuu1]" history-substring-search-up
    bindkey -M "$keymap" "$terminfo[kcud1]" history-substring-search-down
  fi
done

# Vi
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

# Emacs
if [[ -n "$key_info" ]]; then
  bindkey -M emacs "$key_info[Control]P" history-substring-search-up
  bindkey -M emacs "$key_info[Control]N" history-substring-search-down
fi
