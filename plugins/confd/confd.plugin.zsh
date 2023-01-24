# Source eveything in conf.d
for _rcfile in $ZDOTDIR/conf.d/*.zsh(.N); do
  source "$_rcfile"
done
unset _rcfile
