# ohmyzsh
ZSH=$(antidote home)/ohmyzsh/ohmyzsh
MAGIC_ENTER_GIT_COMMAND='git status -sb'
if [[ "$OSTYPE" == darwin* ]]; then
  MAGIC_ENTER_OTHER_COMMAND='command ls -G'
else
  MAGIC_ENTER_OTHER_COMMAND='command ls --color=auto'
fi

# zsh-abbr
ABBR_USER_ABBREVIATIONS_FILE=$ZDOTDIR/.zabbr

# zsh-history-substring-search
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

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
if [[ -n "$key_info" ]]; then
  # vi
  bindkey -M viins "$key_info[Control]F" vi-forward-word
  bindkey -M viins "$key_info[Control]E" vi-add-eol
fi

# zsh-utils
compstyle_zshzoo_setup

# rupa/z or agkozak/zsh-z
_Z_DATA=${XDG_DATA_HOME:-~/.local/share}/z/data
[[ -f $_Z_DATA ]] || { mkdir -p ${_Z_DATA:h} && touch $_Z_DATA }
