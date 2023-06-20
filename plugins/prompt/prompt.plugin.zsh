#
# prompt - Set zsh prompt
#

#
# Requirements
#

[[ "$TERM" != 'dumb' ]] || return 1
0=${(%):-%N}

#
# Options
#

setopt prompt_subst       # Expand parameters in prompt.
setopt transient_rprompt  # Remove right prompt for past commands.

#
# Variables
#

# use 2 space indent for each new level
PS2='${${${(%):-%_}//[^ ]}// /  }    '

#
# Init
#

# set prompt
fpath+="${0:A:h}/functions"
autoload -Uz promptinit && promptinit
