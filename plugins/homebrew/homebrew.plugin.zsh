(( $+commands[brew] )) || return 1

brewcache=${XDG_CACHE_HOME:=~/.cache}/zsh/homebrew.zsh
[[ -d $brewcache:h ]] || mkdir -p $brewcache:h
if [[ ! -f $brewcache ]]; then
  brew shellenv 2> /dev/null | awk '/export HOME/{print}' > $brewcache
fi
source $brewcache
unset brewcache
HOMEBREW_NO_ANALYTICS=1
