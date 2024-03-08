#
# __init__: Run this first!
#

# Initialize profiling.
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Set critical options
setopt extended_glob interactive_comments

# Load .zstyles file.
[[ -r ${ZDOTDIR:-$HOME}/.zstyles ]] && source ${ZDOTDIR:-$HOME}/.zstyles

# Enable Powerlevel10k instant prompt.
if zstyle -t ':zshzoo:plugin:prompt:p10k-instant-prompt' 'enabled'; then
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

# Add hook so that zprof runs only once at the very end.
autoload -Uz add-zsh-hook
if [[ "$ZPROFRC" -eq 1 ]]; then
  function zprof-precmd {
    zprof
    add-zsh-hook -d precmd zprof-precmd
    unset ZPROFRC
  }
  add-zsh-hook precmd zprof-precmd
fi

##? Expand variable names to their values.
function expandvars {
  local v; for v in $@; print ${(P)v}
}

##? Make directory from variables
function mkdir-fromvars {
  local v
  for v in $@; do
    [[ -d "${(P)v}" ]] || mkdir -p "$(P){v}"
  done
}

# Set XDG dirs
if zstyle -T ':z1:environment' use-xdg-basedirs; then
  : ${XDG_CONFIG_HOME:=$HOME/.config}
  : ${XDG_CACHE_HOME:=$HOME/.cache}
  : ${XDG_DATA_HOME:=$HOME/.local/share}
  : ${XDG_STATE_HOME:=$HOME/.local/state}
  export XDG_{CONFIG,CACHE,DATA,STATE}_HOME
  mkdir-fromvars XDG_{CONFIG,CACHE,DATA,STATE}_HOME
fi

# Set Fish-like directories for Zsh
: ${__zsh_config_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}}
: ${__zsh_user_data_dir:=${XDG_DATA_HOME:-$HOME/.local/share}/zsh}
: ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
export __zsh_{config,cache,user_data}_dir
mkdir-fromvars __zsh_{config,cache,user_data}_dir

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Setup homebrew if it exists on the system.
typeset -aU _brewcmd=(
  $HOME/brew/bin/brew(N)
  $commands[brew]
  /opt/homebrew/bin/brew(N)
  /usr/local/bin/brew(N)
  $HOME/.linuxbrew/bin/brew(N)
  /home/linuxbrew/.linuxbrew/bin/brew(N)
)
(( $#_brewcmd )) && source <($_brewcmd[1] shellenv)
unset _brewcmd

# Build remaining path.
path=(
  $HOME/{,s}bin(N)
  $HOME/brew/{,s}bin(N)
  /opt/homebrew/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# Helper functions.
##? Checks if a file can be autoloaded by trying to load it in a subshell.
function is-autoloadable {
  ( unfunction "$1"; autoload -U +X "$1" ) &> /dev/null
}

##? Checks if a name is a command, function, or alias.
function is-callable {
  (( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

##? Check whether a string represents "true" (1, y, yes, t, true, o, on).
function is-true {
  [[ -n "$1" && "$1:l" == (1|y(es|)|t(rue|)|o(n|)) ]]
}

# OS checks
function is-macos  { [[ "$OSTYPE" == darwin* ]] }
function is-linux  { [[ "$OSTYPE" == linux*  ]] }
function is-bsd    { [[ "$OSTYPE" == *bsd*   ]] }
function is-cygwin { [[ "$OSTYPE" == cygwin* ]] }
function is-termux { [[ "$OSTYPE" == linux-android ]] }
