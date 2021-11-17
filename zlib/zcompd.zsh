# completions
ZCOMPD="$ZDOTDIR/completions"
for _compfile in $ZCOMPD/*.zsh(.N); do
  source "$_compfile"
  [[ ${ZPROFRC:-0} -eq 0 ]] || echo "$_compfile completion file sourced"
done
unset _compfile
