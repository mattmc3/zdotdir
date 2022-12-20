#
# Options
#

setopt PROMPT_SUBST  # Expand parameters in prompt.

#
# Init
#

autoload -Uz promptinit && promptinit
[[ -n "$ZSH_PROMPT" ]] && prompt "$ZSH_PROMPT"
