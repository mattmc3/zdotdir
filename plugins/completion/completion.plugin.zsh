#
# Options
#

typeset -ga zopts_completion=(
  COMPLETE_IN_WORD     # Complete from both ends of a word.
  ALWAYS_TO_END        # Move cursor to the end of a completed word.
  PATH_DIRS            # Perform path search even on command names with slashes.
  AUTO_MENU            # Show completion menu on a successive tab press.
  AUTO_LIST            # Automatically list choices on ambiguous completion.
  AUTO_PARAM_SLASH     # If completed parameter is a directory, add a trailing slash.
  NO_MENU_COMPLETE     # Do not autoselect the first completion entry.
  NO_FLOW_CONTROL      # Disable start/stop characters in shell editor.
)
setopt $zopts_completion

#
# Init
#

fpath=(${0:A:h}/functions $fpath)
autoload -Uz $fpath[1]/*(.:t)

: ${ZSH_COMPSTYLE:=zshzoo}
compstyle_${ZSH_COMPSTYLE}_setup

# Allow custom completions directory.
zcfghome=${ZDOTDIR:-${XDG_CONFIG_HOME:=$HOME/.config}}
fpath=($zcfghome/completions(N) $fpath)
run-compinit

#
# Wrap up
#

unset zcfghome
