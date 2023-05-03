#
# prompt - Set zsh prompt.
#

#
# Requirements
#

[[ "$TERM" != 'dumb' ]] || return 1

#
# Options
#

setopt PROMPT_SUBST  # Expand parameters in prompt.

#
# Variables
#

# Set 2 space indent for each new level in a multi-line script
# This can then be overridden by a prompt, but is a better default than zsh's
PS2='${${${(%):-%_}//[^ ]}// /  }    '

#
# Init
#

# Add prompt functions to fpath.
fpath=(${0:A:h}/functions $fpath)

# Initialize Zsh's prompt system
autoload -Uz promptinit && promptinit

# Set the prompt if specified
local -a prompt_theme
zstyle -a ':zsh_custom:plugin:prompt' theme prompt_theme || prompt_theme=starship
prompt $prompt_theme
unset prompt_theme
