# Author: mattmc3
# source: https://github.com/mattmc3/zsh-setopt
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
setopt auto_cd               # If a command is issued that can’t be executed as a normal command,
                             # and the command is the name of a directory, perform the cd command
                             # to that directory.
setopt auto_pushd            # Make cd push the old directory onto the directory stack.
setopt pushd_ignore_dups     # Don’t push multiple copies of the same directory onto the
                             # directory stack.
setopt pushd_minus           # Exchanges the meanings of ‘+’ and ‘-’ when used with a number to
                             # specify a directory in the stack.

#
# 16.2.2 Completions
# http://zsh.sourceforge.net/Doc/Release/Options.html#Completion-2
#
setopt always_to_end       # Move cursor to the end of a completed word.
setopt auto_list           # Automatically list choices on ambiguous completion.
setopt auto_menu           # Show completion menu on a successive tab press.
setopt auto_param_slash    # If completed parameter is a directory, add a trailing slash.
setopt complete_in_word    # Complete from both ends of a word.
unsetopt menu_complete     # Do not autoselect the first completion entry.


#
# 16.2.3 Expansion and Globbing
# http://zsh.sourceforge.net/Doc/Release/Options.html#Expansion-and-Globbing
#
setopt extended_glob       # Needed for file modification glob modifiers with compinit


#
# 16.2.4 History
# http://zsh.sourceforge.net/Doc/Release/Options.html#History
#
setopt append_history            # append to history file
setopt extended_history          # write the history file in the ':start:elapsed;command' format.
unsetopt hist_beep               # don't beep when attempting to access a missing history entry
setopt hist_expire_dups_first    # expire a duplicate event first when trimming history.
setopt hist_find_no_dups         # do not display a previously found event.
setopt hist_ignore_all_dups      # delete an old recorded event if a new event is a duplicate.
setopt hist_ignore_dups          # do not record an event that was just recorded again.
setopt hist_ignore_space         # do not record an event starting with a space.
setopt hist_no_store             # don't store history commands
setopt hist_reduce_blanks        # remove superfluous blanks from each command line being added to the history list.
setopt hist_save_no_dups         # do not write a duplicate event to the history file.
setopt hist_verify               # do not execute immediately upon history expansion.
setopt inc_append_history        # write to the history file immediately, not when the shell exits.
setopt share_history             # share history between all sessions.


#
# 16.2.5 Initialisation
# http://zsh.sourceforge.net/Doc/Release/Options.html#Initialisation
#


#
# 16.2.6 Input/Output
# http://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
#
unsetopt correct               # Try to correct the spelling of commands.
unsetopt correct_all           # Try to correct the spelling of all arguments in a line.
unsetopt flow_control          # Disable start/stop characters in shell editor.
setopt interactive_comments    # Enable comments in interactive shell.
unsetopt mail_warning          # Don't print a warning message if a mail file has been accessed.
setopt path_dirs               # Perform path search even on command names with slashes.
setopt rc_quotes               # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.


#
# 16.2.7 Job Control
# http://zsh.sourceforge.net/Doc/Release/Options.html#Job-Control
#
setopt auto_resume        # Attempt to resume existing job before creating a new process.
unsetopt bg_nice          # Don't run all background jobs at a lower priority.
unsetopt check_jobs       # Don't report on jobs when shell exit.
unsetopt hup              # Don't kill jobs on shell exit.
setopt long_list_jobs     # List jobs in the long format by default.
setopt notify             # Report status of background jobs immediately.


#
# 16.2.8 Prompting
# http://zsh.sourceforge.net/Doc/Release/Options.html#Prompting
#
setopt prompt_subst        # If set, parameter expansion, command substitution and arithmetic
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
unsetopt beep             # Be quiet!
setopt combining_chars    # Combine zero-length punctuation characters (accents) with the
                          # base character.
setopt emacs              # Use Emacs keybindings in the shell
