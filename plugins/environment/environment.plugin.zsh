#
# Options
#

setopt COMBINING_CHARS       # combine zero-length punctuation characters (accents)
                             #   with the base character
setopt INTERACTIVE_COMMENTS  # enable comments in interactive shell
setopt RC_QUOTES             # allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
setopt NO_BEEP               # be quiet
unsetopt MAIL_WARNING        # don't print a warning message if a mail file has been accessed

# job options
setopt LONG_LIST_JOBS        # list jobs in the long format by default
setopt AUTO_RESUME           # attempt to resume existing job before creating a new process
setopt NOTIFY                # report status of background jobs immediately
unsetopt BG_NICE             # don't run all background jobs at a lower priority
unsetopt HUP                 # don't kill jobs on shell exit
unsetopt CHECK_JOBS          # don't report on jobs when shell exit

# built-in magic
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
