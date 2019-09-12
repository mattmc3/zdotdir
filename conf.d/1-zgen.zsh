# zgen is a pretty awesome and simple plugin manager
export ZGEN_DIR=$ZDOTDIR/plugins/zgen
if [[ ! -d "$ZGEN_DIR" ]]; then
  git clone https://github.com/tarjoilija/zgen.git --depth=1 "$ZGEN_DIR"
fi

source "$ZGEN_DIR/zgen.zsh"

if ! zgen saved; then
  # if you change this, don't forget to run zgen reset
  zgen loadall < $ZDOTDIR/zsh_plugins
  zgen save
fi
