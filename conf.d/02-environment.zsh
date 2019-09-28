# environment -------------------------------------------------------------- {{{
export LSCOLORS=ExFxBxDxCxegedabagacad
export TZ="${TZ:-America/New_York}"
export TERM="${TERM:-xterm-256color}"

# Set preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
elif command -v subl &> /dev/null; then
  export EDITOR="subl -n -w"
elif command -v nvim &> /dev/null; then
  export EDITOR="nvim"
else
  export EDITOR="vim"
fi

export VISUAL=${VISUAL:-subl}
export PAGER=${PAGER:-less}

# Set path
path=(
  $HOME/bin
  /usr/local/{sbin,bin}
  /usr/{sbin,bin}
  /{sbin,bin}
  /usr/local/share/npm/bin
  .
  $path
)

typeset -gxU path

# omz
HIST_STAMPS="yyyy-mm-dd"

# plugins
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

# pure prompt
PURE_PROMPT_SYMBOL="%%"
#zstyle :prompt:pure:path color cyan
#zstyle ':prompt:pure:prompt:*' color blue
