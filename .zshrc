# conf.d
setopt extended_glob
for _rcfile in $ZDOTDIR/conf.d/*.zsh(.N); do
  [[ ${_rcfile:t} != '~'* ]] || continue
  source "$_rcfile"
done
unset _rcfile
