#
# color: Make the terminal more colorful.
#

# Return if requirements are not met.
[[ "$TERM" != 'dumb' ]] || return 1

# Built-in zsh colors.
autoload -Uz colors && colors

# Colorize man pages.
export LESS_TERMCAP_md=${LESS_TERMCAP_md:-$fg_bold[blue]}   # start bold
export LESS_TERMCAP_mb=${LESS_TERMCAP_mb:-$fg_bold[blue]}   # start blink
export LESS_TERMCAP_so=${LESS_TERMCAP_so:-$'\e[00;47;30m'}  # start standout: white bg, black fg
export LESS_TERMCAP_us=${LESS_TERMCAP_us:-$'\e[04;35m'}     # start underline: underline magenta
export LESS_TERMCAP_se=${LESS_TERMCAP_se:-$reset_color}     # end standout
export LESS_TERMCAP_ue=${LESS_TERMCAP_ue:-$reset_color}     # end underline
export LESS_TERMCAP_me=${LESS_TERMCAP_me:-$reset_color}     # end bold/blink

# Set LS_COLORS using (g)dircolors if found.
if [[ -z "$LS_COLORS" ]]; then
  _dircolors_cmds=(
    $commands[dircolors](N) $commands[gdircolors](N)
  )
  if (( $#_dircolors_cmds )); then
    if (( $+functions[cached-eval] )); then
      cached-eval "${_dircolors_cmds[1]:t}" "$_dircolors_cmds[1]" --sh
    else
      source <("$_dircolors_cmds[1]" --sh)
    fi
  fi
  unset _dircolors_cmds

  # Pick a reasonable default for LS_COLORS if it hasn't been set by this point.
  export LS_COLORS="${LS_COLORS:-di=34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43}"
fi

# Missing dircolors is a good indicator of a BSD system. Set LSCOLORS for macOS/BSD.
if (( ! $+commands[dircolors] )); then
  # For BSD systems, set LSCOLORS.
  export CLICOLOR=${CLICOLOR:-1}
  export LSCOLORS="${LSCOLORS:-exfxcxdxbxGxDxabagacad}"
fi

# Set aliases.
if ! zstyle -t ':zsh:custom:color:alias' skip; then
  # Print a simple colormap.
  alias colormap='for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+"\n"}; done'

  # Set colors for grep.
  alias grep="${aliases[grep]:-grep} --color=auto"

  # Set colors for ls.
  alias ls="${aliases[ls]:-ls} --color=auto"
  if (( $+commands[gls] )); then
    alias gls="${aliases[gls]:-gls} --color=auto"
  fi

  # Set colors for diff.
  if command diff --color /dev/null{,} &>/dev/null; then
    alias diff="${aliases[diff]:-diff} --color"
  fi
fi

# Colorize completions.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
