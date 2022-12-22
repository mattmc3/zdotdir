#
# Configure Zsh environment.
#

#
# Options
#

# general
setopt COMBINING_CHARS      # Combine zero-length punctuation characters (accents)
                            #   with the base character.
setopt INTERACTIVE_COMMENTS # Enable comments in interactive shell.
setopt RC_QUOTES            # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt MAIL_WARNING       # Don't print a warning message if a mail file has been accessed.

# jobs
setopt LONG_LIST_JOBS       # List jobs in the long format by default.
setopt AUTO_RESUME          # Attempt to resume existing job before creating a new process.
setopt NOTIFY               # Report status of background jobs immediately.
unsetopt BG_NICE            # Don't run all background jobs at a lower priority.
unsetopt HUP                # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS         # Don't report on jobs when shell exit.

#
# Init
#

# built-in paste magic
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#
# Variables
#

# Colored man page support
# using 'less' env vars (format is '\E[<brightness>;<colour>m')
# https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
# color:   0-black, 1-red, 2-green, 3-yellow, 4-blue, 5-magenta, 6-cyan, 7-white
# effects: 0-normal, 1-bold, 2-dim, 3-italic, 4-underline, 5-blink slow, 6-blink fast, 7-reverse
export LESS_TERMCAP_mb=$'\E[01;36m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;36m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[04;35m'      # Begins underline.
