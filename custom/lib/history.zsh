source $ZSH/lib/history.zsh
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
[ -d "${HISTFILE:h}" ] || mkdir -p "${HISTFILE:h}"

## History command configuration
# OMZ settings:
# setopt extended_history       # record timestamp of command in HISTFILE
# setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
# setopt hist_ignore_dups       # ignore duplicated commands history list
# setopt hist_ignore_space      # ignore commands that start with space
# setopt hist_verify            # show command with history expansion to user before running it
# setopt share_history          # share command history data

# My additional settings:
setopt bang_hist               # Treat the '!' character specially during expansion.
setopt hist_find_no_dups       # Do not display a previously found event.
setopt hist_ignore_all_dups    # Delete an old recorded event if a new event is a duplicate.
setopt hist_reduce_blanks      # Remove extra blanks from commands added to the history list.
setopt hist_save_no_dups       # Do not write a duplicate event to the history file.
setopt inc_append_history      # Write to the history file immediately, not when the shell exits.
setopt NO_hist_beep            # Don't beep when accessing non-existent history.
setopt NO_share_history        # Don't share history between all sessions.

# History aliases.
alias hist='fc -li'
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
