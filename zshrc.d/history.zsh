# set history vars and settings
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
[[ -f "$HISTFILE" ]] || { mkdir -p "$HISTFILE:h" && touch "$HISTFILE" }
SAVEHIST=20000
HISTSIZE=100000

setopt hist_no_store            # don't store history commands
setopt hist_reduce_blanks       # remove superfluous blanks from each command line being added to the history list
setopt no_share_history         # allow each session to have its own history
setopt inc_append_history       # add commands to the history file as they are run
setopt inc_append_history_time  # add time command ran to history

alias history="fc -li"        # make the history command more useful

# symlink history file
[[ -L $ZDOTDIR/.zsh_history ]] || ln -sf $HISTFILE $ZDOTDIR/.zsh_history
