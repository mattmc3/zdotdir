# use functions directory for zsh functions
fpath=("$ZDOTDIR"/zfunctions $fpath)
for _zfn in "$ZDOTDIR"/zfunctions/*(.N); do
  autoload -Uz "$_zfn"
done
unset _zfn
