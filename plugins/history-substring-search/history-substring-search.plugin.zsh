source $ZPLUGINDIR/.external/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh

# History substring search config.
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

