#
# Options
#

# Set history options
typeset -ga zopts_history=(
  BANG_HIST                 # Treat the '!' character specially during expansion.
  EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
  NO_SHARE_HISTORY          # Don't share history between all sessions.
  INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
  HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
  HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
  HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
  HIST_FIND_NO_DUPS         # Do not display a previously found event.
  HIST_IGNORE_SPACE         # Do not record an event starting with a space.
  HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
  HIST_VERIFY               # Do not execute immediately upon history expansion.
  HIST_REDUCE_BLANKS        # Remove extra blanks from commands added to the history list.
  NO_HIST_BEEP              # Do not beep when accessing non-existent history.
)
setopt $zopts_history

#
# Variables
#

HISTFILE=${XDG_DATA_HOME:=~/.local/share}/zsh/history
[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h
SAVEHIST=10000
HISTSIZE=10000

#
# Aliases
#

# Lists the ten most used commands.
alias hist-stat='history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head'
alias hist='fc -li'
