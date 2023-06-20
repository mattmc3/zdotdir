#
# history - Set Zsh history options, variables, and aliases.
#

#
# zstyles
#

zstyle ':prezto:module:history' histfile ${XDG_DATA_HOME:=$HOME/.local/share}/zsh/history

#
# Prezto
#

# prezto history
plugin-load sorin-ionescu/prezto/modules/history

# undo bad prezto settings
unsetopt HIST_BEEP         # Do not beep when accessing non-existent history.
unsetopt SHARE_HISTORY     # Do not share history between sessions

#
# Custom
#

# set other history options
setopt INC_APPEND_HISTORY  # Write to the history file immediately, not when the shell exits.
setopt HIST_REDUCE_BLANKS  # Remove extra blanks from commands added to the history list.
