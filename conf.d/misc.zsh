#
# misc - Set general Zsh config options here, or change plugin settings.
#


#
# Options
#

# Fix/reset bad plugin options.
setopt NO_BEEP       # Be quiet!
setopt NO_HIST_BEEP  # Be quiet!


#
# antidote
#

[[ -n "$ANTIDOTE_HOME" ]] || ANTIDOTE_HOME="$(antidote home)"


#
# autosuggestions
#

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

if [[ -n "$key_info" ]]; then
  # vi
  bindkey -M viins "$key_info[Control]F" vi-forward-word
  bindkey -M viins "$key_info[Control]E" vi-add-eol
fi


#
# history-substring-search
#

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

# keybinds
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


#
# OMZ
#

# ohmyzsh
ZSH=$ANTIDOTE_HOME/ohmyzsh/ohmyzsh

# magic-enter
MAGIC_ENTER_GIT_COMMAND='git status -sb'
MAGIC_ENTER_OTHER_COMMAND='ls'


#
# Zsh-Utils
#

# The belek/zsh-utils completion plugin also introduces compstyles. Let's use that!
(( ! $+functions[compstyle_zshzoo_setup] )) || compstyle_zshzoo_setup


#
# zsh-abbr
#

ABBR_USER_ABBREVIATIONS_FILE=$ZDOTDIR/.zabbr

#
# Z
#

ZSHZ_DATA=${XDG_DATA_HOME:=$HOME/.local/share}/z/data
