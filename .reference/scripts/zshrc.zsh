# load lib
zlibs=(
  # profiling is first so that everything gets profiled
  profiling

  # initialize the environment
  setopts
  environment
  completions

  # load plugins
  plugins

  # post-plugins environment
  history
  key-bindings

  # do all my custom stuff
  aliases
  functions
  apps
  prompt
  local
)

# conf.d if order matters
for zshfile in $zlibs; do
  . "${ZDOTDIR}/conf.d/${zshfile}.zsh"
done
unset zshfile
