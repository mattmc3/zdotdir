#
# __init__: Run this first!
#

# Initialize profiling.
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Set critical options
setopt extended_glob interactive_comments

# Load .zstyles file.
[[ -r ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Enable Powerlevel10k instant prompt.
if zstyle -t ':myzsh:feature:prompt:p10k-instant-prompt' 'enabled' &&
   [[ "$ZPROFRC" -ne 1 ]]
then
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

# Load .zshrc.pre file.
[[ -r ${ZDOTDIR:-~}/.zshrc.pre ]] && source ${ZDOTDIR:-~}/.zshrc.pre

#
# Funcs
#

##? Make directory from variables
function mkdir-fromvars {
  local v
  for v in $@; do
    [[ -d "${(P)v}" ]] || mkdir -p "$(P){v}"
  done
}

##? Memoize a command
function cached-eval {
  emulate -L zsh; setopt local_options extended_glob
  (( $# >= 2 )) || return 1

  local cmdname=$1; shift
  local memofile=$__zsh_cache_dir/memoized/${cmdname}.zsh
  local -a cached=($memofile(Nmh-20))
  if ! (( ${#cached} )); then
    mkdir -p ${memofile:h}
    "$@" >| $memofile
  fi
  source $memofile
}

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

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

# Setup homebrew if it exists on the system.
typeset -aU _brewcmd=(
  $HOME/brew/bin/brew(N)
  $commands[brew]
  /opt/homebrew/bin/brew(N)
  /usr/local/bin/brew(N)
  $HOME/.linuxbrew/bin/brew(N)
  /home/linuxbrew/.linuxbrew/bin/brew(N)
)
(( $#_brewcmd )) && cached-eval 'brew_shellenv' $_brewcmd[1] shellenv
unset _brewcmd

# Build remaining path.
path=(
  $HOME/{,s}bin(N)
  $HOME/brew/{,s}bin(N)
  /opt/homebrew/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)
