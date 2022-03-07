#
# Autosuggestions
#

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

if [[ -n "$key_info" ]]; then
  # vi
  bindkey -M viins "$key_info[Control]F" vi-forward-word
  bindkey -M viins "$key_info[Control]E" vi-add-eol
fi

#
# History substring search
#

if [[ -n "$key_info" ]]; then
  # emacs
  bindkey -M emacs "$key_info[Control]P" history-substring-search-up
  bindkey -M emacs "$key_info[Control]N" history-substring-search-down

  # vi
  bindkey -M vicmd "k" history-substring-search-up
  bindkey -M vicmd "j" history-substring-search-down

  # emacs and vi
  for keymap in 'emacs' 'viins'; do
    bindkey -M "$keymap" "$key_info[Up]" history-substring-search-up
    bindkey -M "$keymap" "$key_info[Down]" history-substring-search-down
  done

  unset keymap
fi

#
# Magic-Enter
#

MAGIC_ENTER_GIT_COMMAND="ls -G && git status -sb"  # run when in a git repository
MAGIC_ENTER_OTHER_COMMAND="ls -G"                  # run anywhere else
