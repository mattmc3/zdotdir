#
# utility - Misc Zsh shell options and utilities.
#

#
# Options
#

# Glob options.
setopt EXTENDED_GLOB         # Use more awesome globbing features.
setopt GLOB_DOTS             # Include dotfiles when globbing.
setopt NO_RM_STAR_SILENT     # Ask for confirmation for `rm *' or `rm path/*'

# General options.
setopt COMBINING_CHARS       # Combine 0-len chars with the base character (eg: accents).
setopt INTERACTIVE_COMMENTS  # Enable comments in interactive shell.
setopt RC_QUOTES             # Allow 'Hitchhikers''s Guide' instead of 'Hitchhikers'\''s Guide'.
unsetopt MAIL_WARNING        # Don't print a warning message if a mail file has been accessed.
unsetopt BEEP                # Don't Beep on error in line editor.

# Job options.
setopt LONG_LIST_JOBS        # List jobs in the long format by default.
setopt AUTO_RESUME           # Attempt to resume existing job before creating a new process.
setopt NOTIFY                # Report status of background jobs immediately.
unsetopt BG_NICE             # Don't run all background jobs at a lower priority.
unsetopt HUP                 # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS          # Don't report on jobs when shell exit.

#
# Functions
#

# Autoload functions.
fpath=(${0:A:h}/functions $fpath)
autoload -Uz $fpath[1]/*(.:t)

# Use built-in paste magic.
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#
# Aliases
#

# Common utils everywhere.

# envsubst
if ! (( $+commands[envsubst] )); then
  alias envsubst="python -c 'import os,sys;[sys.stdout.write(os.path.expandvars(l)) for l in sys.stdin]'"
fi

# open
if ! (( $+commands[open] )); then
  if [[ "$OSTYPE" == cygwin* ]]; then
    alias open='cygstart'
  elif [[ "$OSTYPE" == linux-android ]]; then
    alias open='termux-open'
  elif (( $+commands[xdg-open] )); then
    alias open='xdg-open'
  fi
fi

# pbcopy/pbpaste
if ! (( $+commands[pbcopy] )); then
  if [[ "$OSTYPE" == cygwin* ]]; then
    alias pbcopy='tee > /dev/clipboard'
    alias pbpaste='cat /dev/clipboard'
  elif [[ "$OSTYPE" == linux-android ]]; then
    alias pbcopy='termux-clipboard-set'
    alias pbpaste='termux-clipboard-get'
  elif (( $+commands[wl-copy] && $+commands[wl-paste] )); then
    alias pbcopy='wl-copy'
    alias pbpaste='wl-paste'
  elif [[ -n $DISPLAY ]]; then
    if (( $+commands[xclip] )); then
      alias pbcopy='xclip -selection clipboard -in'
      alias pbpaste='xclip -selection clipboard -out'
    elif (( $+commands[xsel] )); then
      alias pbcopy='xsel --clipboard --input'
      alias pbpaste='xsel --clipboard --output'
    fi
  fi
fi

# Load more specific 'run-help' function from $fpath.
(( $+aliases[run-help] )) && unalias run-help && autoload -Uz run-help
alias help=run-help

#
# Misc
#

# Allow mapping Ctrl+S and Ctrl+Q shortcuts
[[ -r ${TTY:-} && -w ${TTY:-} && $+commands[stty] == 1 ]] && stty -ixon <$TTY >$TTY

#
# External
#

plugin-load mattmc3/zman
plugin-load ohmyzsh/ohmyzsh/plugins/extract
path+=($REPO_HOME/romkatv/zsh-bench)
