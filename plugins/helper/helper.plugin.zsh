#region HEADER
#
# helper: Common variables and functions used by Zephyr plugins.
#
#endregion

# Make a directory from a variable name.
function mkdirvar {
  emulate -L zsh
  local zdirvar
  for zdirvar in $@; do
    [[ -d "${(P)zdirvar}" ]] || mkdir -p "$(P){zdirvar}"
  done
}

# Cache the results of an eval command
function cached-eval {
  emulate -L zsh; setopt local_options extended_glob
  (( $# >= 2 )) || return 1

  : ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
  local cmdname=$1; shift
  local cachefile=$__zsh_cache_dir/cached-eval/${cmdname}.zsh
  local -a cached=($cachefile(Nmh-20))
  # If the file has no size (is empty), or is older than 20 hours re-gen the cache.
  if [[ ! -s $cachefile ]] || (( ! ${#cached} )); then
    mkdir -p ${cachefile:h}
    "$@" >| $cachefile
  fi
  source $cachefile
}

# Check if a file can be autoloaded by trying to load it in a subshell.
function is-autoloadable {
  ( unfunction "$1"; autoload -U +X "$1" ) &> /dev/null
}

# Check if a name is a command, function, or alias.
function is-callable {
  (( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

# Check whether a string represents "true" (1, y, yes, t, true, o, on).
function is-true {
  [[ -n "$1" && "$1:l" == (1|y(es|)|t(rue|)|o(n|)) ]]
}

# OS checks.
function is-macos  { [[ "$OSTYPE" == darwin* ]] }
function is-linux  { [[ "$OSTYPE" == linux*  ]] }
function is-bsd    { [[ "$OSTYPE" == *bsd*   ]] }
function is-cygwin { [[ "$OSTYPE" == cygwin* ]] }
function is-termux { [[ "$OSTYPE" == linux-android ]] }

# Check term family.
function is-term-family {
  [[ $TERM = $1 || $TERM = $1-* ]]
}

# Check if tmux.
function is-tmux {
  is-term-family tmux || [[ -n "$TMUX" ]]
}

#region MARK LOADED
zstyle ':zephyr:plugin:helper' loaded 'yes'
#endregion
