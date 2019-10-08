# Author: mattmc3
# Source: https://github.com/mattmc3/zsh-setopt
# License: MIT
#
# http://zsh.sourceforge.net/Doc/Release/Options.html
# Prezto defaults:
#   https://github.com/sorin-ionescu/prezto/blob/master/modules/environment/init.zsh
# OMZ defaults:
#   https://github.com/robbyrussell/oh-my-zsh/tree/master/lib

#
# 16.2.1 Changing Directories
# http://zsh.sourceforge.net/Doc/Release/Options.html#Changing-Directories
#
setopt AUTO_CD               # If a command is issued that can’t be executed as a normal command,
                             # and the command is the name of a directory, perform the cd command
                             # to that directory.
setopt AUTO_PUSHD            # Make cd push the old directory onto the directory stack.
setopt PUSHD_IGNORE_DUPS     # Don’t push multiple copies of the same directory onto the
                             # directory stack.
setopt PUSHD_MINUS           # Exchanges the meanings of ‘+’ and ‘-’ when used with a number to
                             # specify a directory in the stack.

#
# 16.2.2 Completions
# http://zsh.sourceforge.net/Doc/Release/Options.html#Completion-2
#
# options set in completions.zsh
# setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
# setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
# setopt AUTO_MENU           # Show completion menu on a successive tab press.
# setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
# setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
# unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.


#
# 16.2.3 Expansion and Globbing
# http://zsh.sourceforge.net/Doc/Release/Options.html#Expansion-and-Globbing
#
setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit


#
# 16.2.4 History
# http://zsh.sourceforge.net/Doc/Release/Options.html#History
#
# options set in history.zsh
# setopt APPEND_HISTORY            # append to history file
# setopt EXTENDED_HISTORY          # write the history file in the ':start:elapsed;command' format.
# unsetopt HIST_BEEP               # don't beep when attempting to access a missing history entry
# setopt HIST_EXPIRE_DUPS_FIRST    # expire a duplicate event first when trimming history.
# setopt HIST_FIND_NO_DUPS         # do not display a previously found event.
# setopt HIST_IGNORE_ALL_DUPS      # delete an old recorded event if a new event is a duplicate.
# setopt HIST_IGNORE_DUPS          # do not record an event that was just recorded again.
# setopt HIST_IGNORE_SPACE         # do not record an event starting with a space.
# setopt HIST_NO_STORE             # don't store history commands
# setopt HIST_REDUCE_BLANKS        # remove superfluous blanks from each command line being added to the history list.
# setopt HIST_SAVE_NO_DUPS         # do not write a duplicate event to the history file.
# setopt HIST_VERIFY               # do not execute immediately upon history expansion.
# setopt INC_APPEND_HISTORY        # write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY             # share history between all sessions.


#
# 16.2.5 Initialisation
# http://zsh.sourceforge.net/Doc/Release/Options.html#Initialisation
#


#
# 16.2.6 Input/Output
# http://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
#
unsetopt CORRECT               # Try to correct the spelling of commands.
unsetopt CORRECT_ALL           # Try to correct the spelling of all arguments in a line.
unsetopt FLOW_CONTROL          # Disable start/stop characters in shell editor.
setopt INTERACTIVE_COMMENTS    # Enable comments in interactive shell.
unsetopt MAIL_WARNING          # Don't print a warning message if a mail file has been accessed.
setopt PATH_DIRS               # Perform path search even on command names with slashes.
setopt RC_QUOTES               # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.


#
# 16.2.7 Job Control
# http://zsh.sourceforge.net/Doc/Release/Options.html#Job-Control
#
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.
unsetopt HUP              # Don't kill jobs on shell exit.
setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt NOTIFY             # Report status of background jobs immediately.


#
# 16.2.8 Prompting
# http://zsh.sourceforge.net/Doc/Release/Options.html#Prompting
#
setopt PROMPT_SUBST        # If set, parameter expansion, command substitution and arithmetic
                           # expansion are performed in prompts.

#
# 16.2.9 Scripts and Functions
# http://zsh.sourceforge.net/Doc/Release/Options.html#Scripts-and-Functions
#


#
# 16.2.10 Shell Emulation
# http://zsh.sourceforge.net/Doc/Release/Options.html#Shell-Emulation
#

#
# 16.2.11 Shell State
# http://zsh.sourceforge.net/Doc/Release/Options.html#Shell-State
#


#
# 16.2.12 Zle
# http://zsh.sourceforge.net/Doc/Release/Options.html#Zle
#
unsetopt BEEP             # Be quiet!
setopt COMBINING_CHARS    # Combine zero-length punctuation characters (accents) with the
                          # base character.
setopt EMACS              # Use Emacs keybindings in the shell
