#
# agkozak/zsh-z
#

(( $+functions[zshz] )) || return 1
ZSHZ_DATA=${XDG_DATA_HOME:=$HOME/.local/share}/zsh-z/data
[[ -d $ZSHZ_DATA:h ]] || mkdir -p $ZSHZ_DATA:h
