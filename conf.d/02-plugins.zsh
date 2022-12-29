#
# Load plugins via Zephyr.
#

ZEPHYR_HOME=$ZDOTDIR/.zephyr
[[ -d "$ZEPHYR_HOME" ]] || git clone --recursive git@github.com:mattmc3/zephyr "$ZEPHYR_HOME"
source $ZEPHYR_HOME/zephyr.zsh
