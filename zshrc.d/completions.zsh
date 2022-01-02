# load additional completions
if [[ -d $ZDOTDIR/completions ]]; then
  fpath+=$ZDOTDIR/completions
  for f in $ZDOTDIR/completions/*.zsh(.N); do
    source "$f"
  done
fi
unset f
