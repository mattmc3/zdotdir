ZEPHYR_HOME=${ZDOTDIR:-~}/.zephyr
[[ -e $ZEPHYR_HOME ]] || \
  git clone --depth=1 https://github.com/mattmc3/zephyr $ZEPHYR_HOME
# ZEPHYR_HOME=~/Projects/mattmc3/zephyr

zephyr_plugins=(
  environment
  terminal
  editor
  history
  directory
  utility
  zfunctions
  confd
  completions
  autosuggestions
  prompt
  #syntax-highlighting
  history-substring-search
)
zstyle ':zephyr:load' plugins $zephyr_plugins
source $ZEPHYR_HOME/zephyr.zsh
