ZEPHYR_HOME=${ZDOTDIR:-~}/zephyr
[[ -e $ZEPHYR_HOME ]] || \
  git clone --depth=1 git@github.com:mattmc3/zephyr $ZEPHYR_HOME
#ZEPHYR_HOME=~/Projects/mattmc3/zephyr

zstyle ':zephyr:plugins:syntax-highlighting' use-fast-syntax-highlighting yes
zstyle ':zephyr:plugin:prompt' theme pure

zephyr_plugins=(
  environment
  terminal
  editor
  history
  directory
  utility
  prompt
  zfunctions
  confd
  completions
  autosuggestions
  #syntax-highlighting
  history-substring-search
)
zstyle ':zephyr:load' plugins $zephyr_plugins
source $ZEPHYR_HOME/zephyr.zsh
