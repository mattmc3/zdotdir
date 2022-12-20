#
# Executes commands at the start of an interactive session.
#

# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# core
source $ZDOTDIR/lib/zfunctions.zsh
source $ZDOTDIR/lib/directory.zsh
source $ZDOTDIR/lib/editor.zsh
source $ZDOTDIR/lib/environment.zsh
source $ZDOTDIR/lib/history.zsh

# plugins
source $ZDOTDIR/lib/antidote.zsh
# source $ZDOTDIR/lib/unplugged.zsh

# conf.d
source $ZDOTDIR/lib/confd.zsh

# prompt
source $ZDOTDIR/lib/prompt.zsh

# aliases
source $ZDOTDIR/.zaliases

# completions
source $ZDOTDIR/lib/completion.zsh

# local settings
[[ ! -f $DOTFILES.local/zsh/zshrc_local.zsh ]] || source $DOTFILES.local/zsh/zshrc_local.zsh

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
