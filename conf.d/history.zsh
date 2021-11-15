# Prezto doesn't do what I want, so set history vars/opts
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
[[ -f "$HISTFILE" ]] || { mkdir -p "$HISTFILE:h" && touch "$HISTFILE" }
SAVEHIST=20000
HISTSIZE=100000

setopt hist_no_store          # don't store history commands
setopt hist_reduce_blanks     # remove superfluous blanks from each command line being added to the history list

alias history="fc -li"        # make the history command more useful
