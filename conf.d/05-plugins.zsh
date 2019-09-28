# plugins ------------------------------------------------------------------ {{{
# zgen is a pretty awesome and simple plugin manager
export ZGEN_DIR="$ZDOTDIR"/.zgen
[[ -d "$ZGEN_DIR" ]] || git clone https://github.com/tarjoilija/zgen.git --depth=1 "$ZGEN_DIR"

ZGEN_RESET_ON_CHANGE=(${ZDOTDIR:-$HOME}/.zshrc ${0:a})
ZGEN_AUTOLOAD_COMPINIT=false
ZSH=$ZGEN_DIR/robbyrussell/oh-my-zsh-master
ZSH_CUSTOM=$ZGEN_DIR/mattmc3/zsh_custom-master
source "$ZGEN_DIR/zgen.zsh"

# if you change the plugins, you can run `zgen reset` or make sure ZGEN_RESET_ON_CHANGE is set
# pre-zgen
if ! zgen saved; then
  zgen loadall < $ZDOTDIR/zsh_plugins

  # save zgen plugins into init.zsh
  zgen save
fi
