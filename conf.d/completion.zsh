# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day.

: ${ZSH_COMPDUMP:=$ZSH_CACHE_DIR/zcompdump-${ZSH_VERSION}}
autoload -Uz compinit
# #q expands globs in conditional expressions
if [[ $ZSH_COMPDUMP(#qNmh-20) ]]; then
  # -C (skip function check) implies -i (skip security check).
  compinit -C -d "$ZSH_COMPDUMP"
else
  mkdir -p "$ZSH_COMPDUMP:h"
  compinit -i -d "$ZSH_COMPDUMP"
  # Keep $ZSH_COMPDUMP younger than cache time even if it isn't regenerated.
  touch "$ZSH_COMPDUMP"
fi
