# Copyright (c) 2020 mattmc3
# MIT license
# zsh-init.plugin.zsh
# version: 1.1.0
# homepage: https://github.com/mattmc3/zsh-init
#
# A great initial zsh configuration to build off of. Here, I hope you find
# the basic things that should have been set up by default but weren't.


###
# XDG
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME/.xdg}"

if [[ "$OSTYPE" == darwin* ]]; then
  export XDG_DESKTOP_DIR="$HOME/Desktop"
  export XDG_DOCUMENTS_DIR="$HOME/Documents"
  export XDG_DOWNLOAD_DIR="$HOME/Downloads"
  export XDG_MUSIC_DIR="$HOME/Music"
  export XDG_PICTURES_DIR="$HOME/Pictures"
  export XDG_VIDEOS_DIR="$HOME/Videos"
fi


###
# ZSH Options
# http://zsh.sourceforge.net/Doc/Release/Options.html

# Changing Directories
# http://zsh.sourceforge.net/Doc/Release/Options.html#Changing-Directories
setopt auto_cd                 # if a command isn't valid, but is a directory, cd to that dir
setopt auto_pushd              # make cd push the old directory onto the directory stack
setopt pushd_ignore_dups       # don’t push multiple copies of the same directory onto the directory stack
setopt pushd_minus             # exchanges the meanings of ‘+’ and ‘-’ when specifying a directory in the stack

# Completions
# http://zsh.sourceforge.net/Doc/Release/Options.html#Completion-2
setopt always_to_end           # move cursor to the end of a completed word
setopt auto_list               # automatically list choices on ambiguous completion
setopt auto_menu               # show completion menu on a successive tab press
setopt auto_param_slash        # if completed parameter is a directory, add a trailing slash
setopt complete_in_word        # complete from both ends of a word
unsetopt menu_complete         # don't autoselect the first completion entry

# Expansion and Globbing
# http://zsh.sourceforge.net/Doc/Release/Options.html#Expansion-and-Globbing
setopt extended_glob           # use more awesome globbing features
setopt glob_dots               # include dotfiles when globbing

# History
# set in history feature

# Initialization
# http://zsh.sourceforge.net/Doc/Release/Options.html#Initialisation

# Input/Output
# http://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
unsetopt clobber               # must use >| to truncate existing files
unsetopt correct               # don't try to correct the spelling of commands
unsetopt correct_all           # don't try to correct the spelling of all arguments in a line
unsetopt flow_control          # disable start/stop characters in shell editor
setopt interactive_comments    # enable comments in interactive shell
unsetopt mail_warning          # don't print a warning message if a mail file has been accessed
setopt path_dirs               # perform path search even on command names with slashes
setopt rc_quotes               # allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
unsetopt rm_star_silent        # ask for confirmation for `rm *' or `rm path/*'

# Job Control
# http://zsh.sourceforge.net/Doc/Release/Options.html#Job-Control
setopt auto_resume            # attempt to resume existing job before creating a new process
unsetopt bg_nice              # don't run all background jobs at a lower priority
unsetopt check_jobs           # don't report on jobs when shell exit
unsetopt hup                  # don't kill jobs on shell exit
setopt long_list_jobs         # list jobs in the long format by default
setopt notify                 # report status of background jobs immediately

# Prompting
# http://zsh.sourceforge.net/Doc/Release/Options.html#Prompting
setopt prompt_subst           # expand parameters in prompt variables

# Scripts and Functions
# http://zsh.sourceforge.net/Doc/Release/Options.html#Scripts-and-Functions

# Shell Emulation
# http://zsh.sourceforge.net/Doc/Release/Options.html#Shell-Emulation

# Shell State
# http://zsh.sourceforge.net/Doc/Release/Options.html#Shell-State

# Zle
# http://zsh.sourceforge.net/Doc/Release/Options.html#Zle
unsetopt beep                 # be quiet!
setopt combining_chars        # combine zero-length punctuation characters (accents) with the base character
setopt emacs                  # use emacs keybindings in the shell


###
# Environment
export LANG="${LANG:-en_US.UTF-8}"
export LANGUAGE="${LANGUAGE:-en}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"

export CLICOLOR="${CLICOLOR:-1}"
export LSCOLORS="${LSCOLORS:-ExfxcxdxbxGxDxabagacad}"

export PAGER="${PAGER:-less}"
export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-vim}"

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi


###
# History
# http://zsh.sourceforge.net/Doc/Release/Options.html#History
setopt append_history          # append to history file
setopt extended_history        # write the history file in the ':start:elapsed;command' format
setopt no_hist_beep             # don't beep when attempting to access a missing history entry
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
setopt hist_find_no_dups       # don't display a previously found event
setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_dups        # don't record an event that was just recorded again
setopt hist_ignore_space       # don't record an event starting with a space
setopt hist_no_store           # don't store history commands
setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
setopt hist_save_no_dups       # don't write a duplicate event to the history file
setopt hist_verify             # don't execute immediately upon history expansion
setopt inc_append_history      # write to the history file immediately, not when the shell exits
unsetopt share_history         # don't share history between all sessions

# $HISTFILE does not belong with ZSH config files, it belongs in the data space
HISTFILE="${XDG_DATA_HOME}/zsh/history"
if [[ ! -f "$HISTFILE" ]]; then
  mkdir -p "$HISTFILE:h"
  if [[ -f ${ZDOTDIR:-$HOME}/.zsh_history ]] && [[ ! -L ${ZDOTDIR:-$HOME}/.zsh_history ]]; then
    mv ${ZDOTDIR:-$HOME}/.zsh_history "$HISTFILE"
  else
    touch "$HISTFILE"
  fi
fi
if [[ ! -L "${ZDOTDIR:-$HOME}/.zsh_history" ]]; then
  ln -sf "$HISTFILE" "${ZDOTDIR:-$HOME}/.zsh_history"
fi
# you can set $SAVEHIST and $HISTSIZE to anything greater than 1000 and 2000
# respectively, but if not we'll set the values to 5000 and 10000.
[[ $SAVEHIST -gt 1000 ]] || SAVEHIST=5000
[[ $HISTSIZE -gt 2000 ]] || HISTSIZE=10000


###
# Path
path=(
  /usr/local/{sbin,bin}
  /usr/{sbin,bin}
  /{sbin,bin}
  $path
)

# ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path
