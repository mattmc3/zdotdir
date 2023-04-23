#
# rupa/z
#

(( $+functions[_z] )) || return 1
_Z_DATA=${XDG_DATA_HOME:=$HOME/.local/share}/z/data
[[ -d $_Z_DATA:h ]] || mkdir -p $_Z_DATA:h
