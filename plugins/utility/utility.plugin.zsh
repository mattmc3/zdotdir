#!/bin/zsh

#
# Options
#

typeset -ga zopts_general=(
  COMBINING_CHARS       # Combine 0-len chars with base chars (eg: accents).
  INTERACTIVE_COMMENTS  # Enable comments in interactive shell.
  RC_QUOTES             # Allow 'Hitchhiker''s Guide' instead of 'Hitchhiker'\''s Guide'.
  NO_MAIL_WARNING       # Don't print a warning if a mail file was accessed.
)

typeset -ga zopts_jobs=(
  LONG_LIST_JOBS        # List jobs in the long format by default.
  AUTO_RESUME           # Attempt to resume existing job before creating a new process.
  NOTIFY                # Report status of background jobs immediately.
  NO_BG_NICE            # Don't run all background jobs at a lower priority.
  NO_HUP                # Don't kill jobs on shell exit.
  NO_CHECK_JOBS         # Don't report on jobs when shell exit.
)

setopt $zopts_general $zopts_jobs

#
# Built-ins
#

# Use built-in paste magic.
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#
# Aliases
#

# macOS utils everywhere
if [[ "$OSTYPE" == cygwin* ]]; then
  (( $+commands[open] )) || alias open='cygstart'
  alias pbcopy='tee > /dev/clipboard'
  alias pbpaste='cat /dev/clipboard'
elif [[ "$OSTYPE" == linux-android ]]; then
  (( $+commands[open] )) || alias open='termux-open'
  alias pbcopy='termux-clipboard-set'
  alias pbpaste='termux-clipboard-get'
elif [[ "$OSTYPE" != darwin* ]]; then
  (( $+commands[open] )) || alias open='xdg-open'
  if [[ -n $DISPLAY ]]; then
    if (( $+commands[xclip] )); then
      alias pbcopy='xclip -selection clipboard -in'
      alias pbpaste='xclip -selection clipboard -out'
    elif (( $+commands[xsel] )); then
      alias pbcopy='xsel --clipboard --input'
      alias pbpaste='xsel --clipboard --output'
    fi
  else
    if (( $+commands[wl-copy] && $+commands[wl-paste] )); then
      alias pbcopy='wl-copy'
      alias pbpaste='wl-paste'
    fi
  fi
fi

# Load more specific 'run-help' function from $fpath.
(( $+aliases[run-help] )) && unalias run-help && autoload -Uz run-help
alias help=run-help
