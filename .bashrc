export BASHDOTDIR="${BASHDOTDIR:-$HOME/.shell}"
if [[ -d "$BASHDOTDIR"/conf.d ]]; then
  for file in "$BASHDOTDIR"/conf.d/*+(.sh|.bash); do
    source "$file"
  done
fi
[[ -f "$BASHDOTDIR"/.shellrc.local ]] && . "$BASHDOTDIR"/.shellrc.local
