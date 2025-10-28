#
# prompt: Set up the Zsh prompt system.
#

# Initialize prompt
setopt prompt_subst
autoload -Uz promptinit && promptinit
prompt powerlevel10k
source $ZDOTDIR/.p10k.zsh
