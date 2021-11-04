export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget/wget-hsts"'
[[ -f "$WGETRC" ]] || { mkdir -p "$WGETRC:h" && touch "$WGETRC" }
[[ -f "$XDG_CACHE_HOME/wget/wget-hsts" ]] || { mkdir -p "$XDG_CACHE_HOME/wget" && touch "$XDG_CACHE_HOME/wget/wget-hsts" }
