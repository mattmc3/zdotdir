# load lib
zlibs=(
  # profiling is first so that everything gets profiled
  profiling

  # set up the environment correctly
  setopts
  history
  environment
  key-bindings
  completions

  # load plugins
  plugins

  # do all my custom stuff
  aliases
  functions
  apps
  local
)

# conf.d if order matters
for zshfile in $zlibs; do
  . "${ZDOTDIR}/conf.d/${zshfile}.zsh"
done
unset zshfile

# conf.d if order doesn't matter
# for zshfile in $ZDOTDIR/conf.d/*.{sh,zsh}(N); do
#   case $zshfile:t in ~*) continue;; esac
#   . "$zshfile"
# done
# unset zshfile
