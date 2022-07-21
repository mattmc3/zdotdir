# Plugin setup

#region: ohmyzsh/ohmyzsh
# using omz without sourcing its lib requires a few helpers
alias open_command=open

# magic-enter plugin config
if [[ "$OSTYPE" == darwin* ]]; then
  MAGIC_ENTER_OTHER_COMMAND='ls -G'
else
  MAGIC_ENTER_OTHER_COMMAND='ls --color=auto'
fi
MAGIC_ENTER_GIT_COMMAND="$MAGIC_ENTER_OTHER_COMMAND && git status -sb"

alias pbc=clipcopy
alias pbp=clippaste
#endregion

#region: zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
if [[ -n "$key_info" ]]; then
  # vi
  bindkey -M viins "$key_info[Control]F" vi-forward-word
  bindkey -M viins "$key_info[Control]E" vi-add-eol
fi
#endregion

#region: olets/zsh-abbr
ABBR_USER_ABBREVIATIONS_FILE=$ZDOTDIR/.zabbr
#endregion

#region: zsh-users/zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

if [[ -n "$key_info" ]]; then
  # Emacs
  bindkey -M emacs "$key_info[Control]P" history-substring-search-up
  bindkey -M emacs "$key_info[Control]N" history-substring-search-down

  # Vi
  bindkey -M vicmd "k" history-substring-search-up
  bindkey -M vicmd "j" history-substring-search-down

  # Emacs and Vi
  for keymap in 'emacs' 'viins'; do
    bindkey -M "$keymap" "$key_info[Up]" history-substring-search-up
    bindkey -M "$keymap" "$key_info[Down]" history-substring-search-down
  done

  unset keymap
fi
#endregion
