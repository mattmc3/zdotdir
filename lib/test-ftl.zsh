fpath=($HOME/Projects/mattmc3/starship-ftl/themes $fpath)

function test-no-ftl() {
  # Test without FTL prompt
  autoload -Uz promptinit && promptinit
  prompt starship zsh
}

function test-ftl() {
  # Test with FTL prompt
  source $HOME/Projects/mattmc3/starship-ftl/ftl-prompt.zsh
  ftl-prompt starship zsh
  echo sleeping beauty
  sleep 2
  echo >&2 awake
}
