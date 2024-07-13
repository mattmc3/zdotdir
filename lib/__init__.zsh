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

# Load .zstyles file.
[[ -r ${ZDOTDIR:-$HOME}/.zstyles ]] && source ${ZDOTDIR:-$HOME}/.zstyles

# Instant prompt
if zstyle -t ':zephyr:plugin:prompt:powerlevel10k' instant-prompt; then
  # Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

# Define functions
##? Cache the results of an eval command
function cached-eval {
  emulate -L zsh; setopt local_options extended_glob
  (( $# >= 2 )) || return 1

  local cmdname=$1; shift
  local cachefile=$__zsh_cache_dir/cached/${cmdname}.zsh
  local -a cached=($cachefile(Nmh-20))
  # If the file has no size (is empty), or is older than 20 hours re-gen the cache.
  if [[ ! -s $cachefile ]] || (( ! ${#cached} )); then
    mkdir -p ${cachefile:h}
    "$@" >| $cachefile
  fi
  source $cachefile
}

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
  if zstyle -t ':zephyr:plugin:homebrew' 'use-cache'; then
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

# Load .zshrc.pre file.
[[ -r ${ZDOTDIR:-$HOME}/.zshrc.pre ]] && source ${ZDOTDIR:-$HOME}/.zshrc.pre
