export _Z_DATA="$XDG_DATA_HOME/z/data"
[[ -f "$_Z_DATA" ]] || { mkdir -p "$_Z_DATA:h" && touch "$_Z_DATA" }
