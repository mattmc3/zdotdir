#
# node
#

path+=(
  /{opt/homebrew,usr/local}/share/npm/bin(N)
)
export NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG:-$XDG_CONFIG_HOME/npm/npmrc}"
export NODE_REPL_HISTORY="${NODE_REPL_HISTORY:-$XDG_DATA_HOME/nodejs/repl_history}"
