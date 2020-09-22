# load plugins
## antibody dynamic
# export ANTIBODY_HOME="$ZDOTDIR/zplugins"
# source <(antibody init)
# envsubst < $ZDOTDIR/.zplugins | antibody bundle

path=( /usr/local/{sbin,bin} $path )
zplugins_file="$ZDOTDIR/zlib/zplugins.zsh"
if [[ ! -d "$ANTIBODY_HOME" ]] && [[ -f "$zplugins_file" ]]; then
  rm -f "$zplugins_file"
fi
if [[ ! -f "$zplugins_file" ]] || [[ $ZDOTDIR/.zplugins -nt "$zplugins_file" ]]; then
  envsubst < $ZDOTDIR/.zplugins | antibody bundle >| $zplugins_file
  sed -i '' "s|$HOME|\$HOME|g" $zplugins_file
fi
source $zplugins_file
unset zplugins_file
