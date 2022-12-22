#
# Configure Zsh utilities.
#

0=${(%):-%N}
autoload-dir ${0:A:h}/functions

# built-in paste magic
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Load more specific zsh 'run-help' function.
(( $+aliases[run-help] )) && unalias run-help && autoload -Uz run-help
alias help=run-help

# zsh benchmarking
path=(
  $ZPLUGINDIR/.external/zsh-bench
  $path
)

# zman
source $ZPLUGINDIR/.external/zman/zman.zsh

# Colored man page support.
# (format is '\E[<brightness>;<colour>m')
# https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
# color:   0-black, 1-red, 2-green, 3-yellow, 4-blue, 5-magenta, 6-cyan, 7-white
# effects: 0-normal, 1-bold, 2-dim, 3-italic, 4-underline, 5-blink slow, 6-blink fast, 7-reverse
export LESS_TERMCAP_mb=$'\E[01;34m'      # mb:=start blink-mode (bold,blue)
export LESS_TERMCAP_md=$'\E[01;34m'      # md:=start bold-mode (bold,blue)
export LESS_TERMCAP_so=$'\E[00;47;30m'   # so:=start standout-mode (white bg, black fg)
export LESS_TERMCAP_us=$'\E[04;35m'      # us:=start underline-mode (underline magenta)
export LESS_TERMCAP_se=$'\E[0m'          # se:=end standout-mode
export LESS_TERMCAP_ue=$'\E[0m'          # ue:=end underline-mode
export LESS_TERMCAP_me=$'\E[0m'          # me:=end modes
