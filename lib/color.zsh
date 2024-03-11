#
# color: Make the terminal more colorful.
#

# Built-in zsh colors.
autoload -Uz colors && colors

# Colorize man pages.
export LESS_TERMCAP_md=$fg_bold[blue]   # start bold
export LESS_TERMCAP_mb=$fg_bold[blue]   # start blink
export LESS_TERMCAP_so=$'\e[00;47;30m'  # start standout: white bg, black fg
export LESS_TERMCAP_us=$'\e[04;35m'     # start underline: underline magenta
export LESS_TERMCAP_se=$reset_color     # end standout
export LESS_TERMCAP_ue=$reset_color     # end underline
export LESS_TERMCAP_me=$reset_color     # end bold/blink

# Set colors for grep.
alias grep="${aliases[grep]:-grep} --color=auto"

# Set colors for ls
if [[ "$OSTYPE" == darwin* ]] || (( ! $+commands[dircolors] )); then
  alias ls="${aliases[ls]:-ls} -G"
else
  alias ls="${aliases[ls]:-ls} --group-directories-first --color=auto"
fi

# Set GNU LS_COLORS
if [[ -z "$LS_COLORS" ]]; then
  if (( $+commands[dircolors] )); then
    cached-eval 'dircolors' dircolors -b
  elif (( $+commands[gdircolors] )); then
    cached-eval 'gdircolors' gdircolors -b
  else
    export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43"
  fi
fi

# Missing dircolors is a good indicator of a BSD system. Set LSCOLORS for macOS/BSD.
if (( ! $+commands[dircolors] )); then
  # For BSD systems, set LSCOLORS
  export CLICOLOR=${CLICOLOR:-1}
  export LSCOLORS="${LSCOLORS:-exfxcxdxbxGxDxabagacad}"
fi

# Use diff --color if available
if command diff --color /dev/null{,} &>/dev/null; then
  alias diff="${aliases[diff]:-diff} --color"
fi

# Set completion colors.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
