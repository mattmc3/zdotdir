# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day.

: ${ZSH_CACHE_DIR:-${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
: ${ZSH_COMPDUMP:=${ZSH_CACHE_DIR:-}/zcompdump-${ZSH_VERSION}}
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

# zsh ignores a .zwc older than its source, so a regenerated dump silently
# stops being read from the compiled copy. Rebuild it in the background, and
# only when it is actually stale, so the usual startup does not fork.
if [[ ! -e "$ZSH_COMPDUMP.zwc" || "$ZSH_COMPDUMP" -nt "$ZSH_COMPDUMP.zwc" ]]; then
  autoload -Uz zrecompile && zrecompile -pq "$ZSH_COMPDUMP" &!
fi
