#
# z - jump around
#

plugin-load rupa/z
_Z_DATA=${XDG_DATA_HOME:-~/.local/share}/z/data
[[ -d $_Z_DATA:h ]] || mkdir -p $_Z_DATA:h
