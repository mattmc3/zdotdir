# prezto ------------------------------------------------------------------- {{{
if [[ -s "${ZDOTDIR:-$HOME}/plugins/prezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/plugins/prezto/init.zsh"
fi

# Unset stuff from prezto...
unsetopt correct
unsetopt correctall
DISABLE_CORRECTION="true"

# history
SAVEHIST="100000"
HISTSIZE="100000"
HISTFILE="$XDG_DATA_HOME/zsh/history"

setopt append_history
setopt hist_reduce_blanks
setopt inc_append_history
setopt no_hist_beep


# other options not set by prezto ------------------------------------------ {{{
# completions
setopt always_to_end
setopt complete_in_word

# changing directories
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

# I/O
# Allow comments even in interactive shells.
setopt no_flow_control

# prompting
setopt prompt_subst

# zle
setopt emacs
setopt no_beep  # quiet!
