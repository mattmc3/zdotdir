#
# Set zsh prompt.
#

#
# Options
#

setopt PROMPT_SUBST  # Expand parameters in prompt.

#
# Variables
#

# https://unix.stackexchange.com/questions/685666/zsh-how-do-i-remove-block-prefixes-when-writing-multi-line-statements-in-intera
# use 2 space indent for each new level
PS2='${${${(%):-%_}//[^ ]}// /  }    '
PURE_PROMPT_SYMBOL="%%"

#
# Init
#

autoload -Uz promptinit && promptinit
prompt pure

# show exit code on right
function precmd_pipestatus {
  local exitcodes="${(j.|.)pipestatus}"
  if [[ "$exitcodes" != "0" ]]; then
    RPROMPT="%F{$prompt_pure_colors[prompt:error]}[$exitcodes]%f"
  else
    RPROMPT=
  fi
}
add-zsh-hook precmd precmd_pipestatus
