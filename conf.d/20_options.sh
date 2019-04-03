if [[ -n $ZSH_VERSION ]]; then
  # completions
  setopt ALWAYS_TO_END
  setopt COMPLETE_IN_WORD

  # changing directories
  setopt AUTO_CD
  setopt AUTO_PUSHD
  setopt PUSHD_IGNORE_DUPS
  setopt PUSHD_MINUS

  # I/O
  # Allow comments even in interactive shells.
  setopt INTERACTIVE_COMMENTS
  setopt NO_FLOW_CONTROL

  # job control
  # Print job notifications in the long format by default.
  setopt LONG_LIST_JOBS

  # prompting
  setopt PROMPT_SUBST

  # zle
  setopt EMACS
  setopt NO_BEEP  # QUIET!

  # history
  SAVEHIST="${SAVEHIST:-100000}"
  HISTSIZE="${HISTSIZE:-100000}"
  HIST_STAMPS="${HIST_STAMPS:-yyyy-mm-dd}"  # https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/history.zsh
  HISTFILE="$HOME/.zsh_history"

  setopt append_history
  setopt extended_history
  setopt hist_expire_dups_first
  setopt hist_find_no_dups
  setopt hist_ignore_dups
  setopt hist_ignore_space
  setopt hist_reduce_blanks
  setopt hist_verify
  setopt inc_append_history
  setopt no_hist_beep
  setopt share_history

elif [[ -n $BASH_VERSION ]]; then
  # Prevent file overwrite on stdout redirection
  # Use `>|` to force redirection to an existing file
  set -o noclobber

  # Update window size after every command
  shopt -s checkwinsize

  # Append to the history file, don't overwrite it
  shopt -s histappend

  # Save multi-line commands as one command
  shopt -s cmdhist

  ## BETTER DIRECTORY NAVIGATION ##

  # Turn on extended globbing (http://www.gnu.org/software/bash/manual/bashref.html#Pattern-Matching)
  shopt -s extglob 2> /dev/null
  # Turn on recursive globbing (enables ** to recurse all directories)
  shopt -s globstar 2> /dev/null
  # Case-insensitive globbing (used in pathname expansion)
  shopt -s nocaseglob;
  # Prepend cd to directory names automatically
  shopt -s autocd 2> /dev/null
  # Correct spelling errors during tab-completion
  shopt -s dirspell 2> /dev/null
  # Correct spelling errors in arguments supplied to cd
  shopt -s cdspell 2> /dev/null

  # This allows you to bookmark your favorite places across the file system
  # Define a variable containing a path and you will be able to cd into it
  # regardless of the directory you're in
  shopt -s cdable_vars

  # Set vi editing mode
  # set -o vi
fi
