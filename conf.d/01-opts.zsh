# no autocorrect
unsetopt CORRECT
unsetopt CORRECTALL

# changing directories
setopt AUTO_CD               # If a command is issued that can’t be executed as a normal command,
                             # and the command is the name of a directory, perform the cd command to that directory.
setopt AUTO_PUSHD            # Make cd push the old directory onto the directory stack.
setopt PUSHD_IGNORE_DUPS     # Don’t push multiple copies of the same directory onto the directory stack.
setopt PUSHD_MINUS           # Exchanges the meanings of ‘+’ and ‘-’ when used with a number to specify a directory in the stack.

# prompting
setopt PROMPT_SUBST

# zle
setopt EMACS
unsetopt BEEP                # Be quiet!

# completions
setopt COMPLETE_IN_WORD      # Complete from both ends of a word.
setopt ALWAYS_TO_END         # Move cursor to the end of a completed word.
setopt PATH_DIRS             # Perform path search even on command names with slashes.
setopt AUTO_MENU             # Show completion menu on a successive tab press.
setopt AUTO_LIST             # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH      # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB         # Needed for file modification glob modifiers with compinit
unsetopt MENU_COMPLETE       # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL        # Disable start/stop characters in shell editor.


# Prezto has some good defauls
# https://github.com/sorin-ionescu/prezto/blob/master/modules/environment/init.zsh

#
# General
#
setopt COMBINING_CHARS       # Combine zero-length punctuation characters (accents)
                             # with the base character.
setopt INTERACTIVE_COMMENTS  # Enable comments in interactive shell.
setopt RC_QUOTES             # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt MAIL_WARNING        # Don't print a warning message if a mail file has been accessed.

#
# Jobs
#
setopt LONG_LIST_JOBS       # List jobs in the long format by default.
setopt AUTO_RESUME          # Attempt to resume existing job before creating a new process.
setopt NOTIFY               # Report status of background jobs immediately.
unsetopt BG_NICE            # Don't run all background jobs at a lower priority.
unsetopt HUP                # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS         # Don't report on jobs when shell exit.
