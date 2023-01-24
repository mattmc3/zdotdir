#!/bin/zsh

#
# Options
#

# Set prompt options
typeset -ga zopts_prompt=(
  PROMPT_SUBST   # Substitute environment variables in prompt variables.
)
setopt $zopts_prompt

#
# Init
#

autoload -Uz promptinit && promptinit

: ${ZSH_THEME:=powerlevel10k}
prompt ${ZSH_THEME}

if [[ ${ZSH_THEME} == powerlevel10k ]]; then
  source ${0:A:h}/p10k.zsh
elif [[ ${ZSH_THEME} == pure ]]
  # TODO
fi
