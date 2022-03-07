#
# Options
#

# http://zsh.sourceforge.net/Doc/Release/Options.html#History
setopt APPEND_HISTORY          # append to history file
setopt HIST_NO_STORE           # don't store history commands
setopt HIST_REDUCE_BLANKS      # remove superfluous blanks from each command line being added to the history list
setopt NO_SHARE_HISTORY        # don't share history between all sessions
setopt BANG_HIST               # treat the '!' character specially during expansion
setopt EXTENDED_HISTORY        # write the history file in the ':start:elapsed;command' format
setopt INC_APPEND_HISTORY      # write to the history file immediately, not when the shell exits
setopt HIST_EXPIRE_DUPS_FIRST  # expire a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS        # do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS    # delete an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS       # do not display a previously found event
setopt HIST_IGNORE_SPACE       # do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS       # do not write a duplicate event to the history file
setopt HIST_VERIFY             # do not execute immediately upon history expansion
setopt NO_HIST_BEEP            # don't beep when attempting to access a missing history entry

#
# Variables
#

# $HISTFILE belongs in the data home, not with the configs
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
if [[ ! -f "$HISTFILE" ]]; then
  mkdir -p "$HISTFILE:h" && touch "$HISTFILE"
fi

# you can set $SAVEHIST and $HISTSIZE to anything greater than the ZSH defaults
# (1000 and 2000 respectively), but if not we make them way bigger.
[[ $SAVEHIST -gt 1000 ]] || SAVEHIST=10000
[[ $HISTSIZE -gt 2000 ]] || HISTSIZE=20000

#
# Aliases
#

# lists the ten most used commands
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# make the history command more useful
alias history="fc -li"
