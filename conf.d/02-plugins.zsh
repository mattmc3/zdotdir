#
# Load plugins via Zephyr.
#

ZEPHYR_HOME=$ZDOTDIR/.zephyr
[[ -d "$ZEPHYR_HOME" ]] || git clone git@github.com:mattmc3/zephyr "$ZEPHYR_HOME"

plugins=(
  # core
  zfunctions
  environment
  colors
  directory
  editor
  history
  prompt
  utility

  # plugins
  autosuggestions
  clipboard
  macos
  python
  string
  sudo
  z

  # omz plugins
  extract
  fancy-ctrl-z
  magic-enter
  sudo

  # load last
  abbreviations
  zopts
  completion
  syntax-highlighting
  history-substring-search
)

source $ZEPHYR_HOME/zephyr.zsh

# set prompt
prompt powerlevel10k
source $ZDOTDIR/lib/p10k.zsh

# Use Emacs keys.
bindkey -e

# Set plugin variables.
MAGIC_ENTER_GIT_COMMAND='git status -sb'
if [[ "$OSTYPE" == darwin* ]]; then
  MAGIC_ENTER_OTHER_COMMAND='command ls -G'
else
  MAGIC_ENTER_OTHER_COMMAND='command ls --color=auto'
fi
