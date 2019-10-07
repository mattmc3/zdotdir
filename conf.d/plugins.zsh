### plugins pre ------------------------------------------------------------ {{{
# set anything that needs set before plugins load


### plugins ---------------------------------------------------------------- {{{
# zgen is a pretty awesome and simple plugin manager
export ZGEN_DIR="${ZDOTDIR:-$HOME}"/.zgen
[[ -d "$ZGEN_DIR" ]] || git clone https://github.com/tarjoilija/zgen.git --depth=1 "$ZGEN_DIR"
ZGEN_RESET_ON_CHANGE=(${ZDOTDIR:-$HOME}/.zshrc ${ZDOTDIR:-$HOME}/zsh_plugins)
ZGEN_AUTOLOAD_COMPINIT=false

# if plugins change run `zgen reset` or monitor files w/ ZGEN_RESET_ON_CHANGE
source "$ZGEN_DIR/zgen.zsh"
if ! zgen saved; then
  zgen clone robbyrussell/oh-my-zsh
  zgen clone mattmc3/zsh_custom

  zgen loadall < $ZDOTDIR/zsh_plugins

  # save zgen plugins into init.zsh
  zgen save
fi


### plugins post ----------------------------------------------------------- {{{
# plugin variables
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
PURE_PROMPT_SYMBOL="%%"
#zstyle :prompt:pure:path color cyan
#zstyle ':prompt:pure:prompt:*' color blue
