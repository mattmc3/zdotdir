#
# __init__: Run this first!
#

# Initialize profiling.
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Set critical options
setopt extended_glob

# Set critical vars
: ${__zsh_config_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}}
: ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
: ${__zsh_user_data_dir:=${XDG_DATA_HOME:-$HOME/.local/share}/zsh}
() {
  local _zdir; for _zdir in $@; [ -d ${(P)_zdir} ] || mkdir -p ${(P)_zdir}
} __zsh_{config,cache,user_data}_dir

# Define critical functions
##? Cache the results of an eval command
function cached-eval {
  emulate -L zsh; setopt local_options extended_glob
  (( $# >= 2 )) || return 1

  local cmdname=$1; shift
  local memofile=$__zsh_cache_dir/memoized/${cmdname}.zsh
  local -a cached=($memofile(Nmh-20))
  # If the file has no size (is empty), or is older than 20 hours re-gen the cache.
  if [[ ! -s $memofile ]] || (( ! ${#cached} )); then
    mkdir -p ${memofile:h}
    "$@" >| $memofile
  fi
  source $memofile
}

# Load .zstyles file.
[[ -r ${ZDOTDIR:-$HOME}/.zstyles ]] && source ${ZDOTDIR:-$HOME}/.zstyles

# Load .zshrc.pre file.
[[ -r ${ZDOTDIR:-$HOME}/.zshrc.pre ]] && source ${ZDOTDIR:-$HOME}/.zshrc.pre

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Setup homebrew if it exists on the system.
typeset -aU _brewcmd=(
  $HOME/.homebrew/bin/brew(N)
  $HOME/.linuxbrew/bin/brew(N)
  /opt/homebrew/bin/brew(N)
  /usr/local/bin/brew(N)
  /home/linuxbrew/.linuxbrew/bin/brew(N)
)
if (( $#_brewcmd )); then
  if zstyle -t ':kickstart.zsh:feature:homebrew' 'use-cache'; then
    cached-eval 'brew_shellenv' $_brewcmd[1] shellenv
  else
    source <($_brewcmd[1] shellenv)
  fi
fi
unset _brewcmd

# Build remaining path.
path=(
  $HOME/{,s}bin(N)
  $HOME/.local/bin(N)
  $HOMEBREW_PREFIX/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)
