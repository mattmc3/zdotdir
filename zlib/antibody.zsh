# load plugins
## antibody dynamic
# export ANTIBODY_HOME="$ZDOTDIR/zplugins"
# source <(antibody init)
# envsubst < $ZDOTDIR/.zplugins | antibody bundle

path=( /usr/local/{sbin,bin} $path )
zplugins_file="$ZDOTDIR/.zplugins"
zplugins_gen="$ZDOTDIR/zlib/zplugins.zsh"
[[ -n "$ANTIBODY_HOME" ]] || ANTIBODY_HOME=$(antibody home)
if [[ ! -d "$ANTIBODY_HOME" ]] && [[ -f "$zplugins_gen" ]]; then
  rm -f "$zplugins_gen"
fi
if [[ ! -f "$zplugins_gen" ]] || [[ "$zplugins_file" -nt "$zplugins_gen" ]]; then
  envsubst < "$zplugins_file" | antibody bundle >| $zplugins_gen
  # disguise directories
  sed -i '' "s|$ANTIBODY_HOME|\$ANTIBODY_HOME|g" $zplugins_gen
  sed -i '' "s|$ZDOTDIR|\$ZDOTDIR|g" $zplugins_gen
  sed -i '' "s|$HOME|\$HOME|g" $zplugins_gen
fi
source $zplugins_gen
unset zplugins_file zplugins_gen
