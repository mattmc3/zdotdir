(( $+functions[history-substring-search-up] )) || return 1

# zstyle -s ':prezto:module:history-substring-search:color' found \
#   'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND' \
#     || HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'

# zstyle -s ':prezto:module:history-substring-search:color' not-found \
#   'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND' \
#     || HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

# zstyle -s ':prezto:module:history-substring-search' globbing-flags \
#   'HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS' \
#     || HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

# if zstyle -t ':prezto:module:history-substring-search' case-sensitive; then
#   HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS="${HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS//i}"
# fi

# if ! zstyle -t ':prezto:module:history-substring-search' color; then
#   unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_{FOUND,NOT_FOUND}
# fi

# if zstyle -t ':prezto:module:history-substring-search' fuzzy; then
#   HISTORY_SUBSTRING_SEARCH_FUZZY=1
# fi

# if zstyle -t ':prezto:module:history-substring-search' unique; then
#   HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
# fi

# if zstyle -t ':prezto:module:history-substring-search' prefixed; then
#   HISTORY_SUBSTRING_SEARCH_PREFIXED=1
# fi

#
# Key Bindings
#

# Emacs
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# Vi
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down

# Emacs and Vi
for _keymap in 'emacs' 'viins'; do
  bindkey -M "$keymap" "$terminfo[kcuu1]" history-substring-search-up
  bindkey -M "$keymap" "$terminfo[kcud1]" history-substring-search-down
done

unset _keymap
