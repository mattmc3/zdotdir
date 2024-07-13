#
# misc: Set misc Zsh options and settings that don't fit elsewhere.
#

# 16.2.6 Input/Output
setopt interactive_comments    # Enable comments in interactive shell.
setopt rc_quotes               # Allow 'Hitchhikers''s Guide' instead of 'Hitchhikers'\''s Guide'.
setopt NO_flow_control         # Disable start/stop characters (usually ^Q/^S) in shell editor.
setopt NO_mail_warning         # Don't print a warning message if a mail file has been accessed.

# 16.2.7 Job Control
setopt auto_resume             # Attempt to resume existing job before creating a new process.
setopt long_list_jobs          # List jobs in the long format by default.
setopt notify                  # Report status of background jobs immediately.
setopt NO_bg_nice              # Don't run all background jobs at a lower priority.
setopt NO_check_jobs           # Don't report on jobs when shell exit.
setopt NO_hup                  # Don't kill jobs on shell exit.

# 16.2.12 Zle
setopt combining_chars         # Combine 0-len chars with the base character (eg: accents).
setopt NO_beep                 # Beep on error in line editor.

# Allow mapping Ctrl+S and Ctrl+Q shortcuts
[[ -r ${TTY:-} && -w ${TTY:-} && $+commands[stty] == 1 ]] && stty -ixon <$TTY >$TTY
