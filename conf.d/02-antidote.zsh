# Lazy-load antidote and generate the static load file only when needed.
source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh
zplugins=${ZDOTDIR:-$HOME}/.zplugins
if [[ ! ${zplugins}.zsh -nt ${zplugins} ]]; then
  (antidote bundle <${zplugins} >${zplugins}.zsh)
fi
source ${zplugins}.zsh

# Customize plugins
ABBR_USER_ABBREVIATIONS_FILE=$ZDOTDIR/.zabbr
MAGIC_ENTER_GIT_COMMAND='git status -sb'
MAGIC_ENTER_OTHER_COMMAND='ls'
ZSH_COMPDUMP=$XDG_CACHE_HOME/prezto/zcompdump
_Z_DATA=$XDG_DATA_HOME/z/data
[[ -d $_Z_DATA:h ]] || mkdir -p $_Z_DATA:h
