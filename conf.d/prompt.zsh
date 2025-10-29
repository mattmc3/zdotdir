#
# prompt: Set up the Zsh prompt system.
#

# Initialize prompt
setopt prompt_subst transient_rprompt
autoload -Uz promptinit && promptinit
prompt p10k mmc
#source $ZDOTDIR/.p10k.zsh
