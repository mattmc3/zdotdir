# rupa/z

_Z_DATA=$XDG_DATA_HOME/z/data
[[ -d $_Z_DATA:h ]] || mkdir -p $_Z_DATA:h
noexpand_aliases+=(z)
