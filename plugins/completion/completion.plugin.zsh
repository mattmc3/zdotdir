#region HEADER
#
# completion: Set up zsh completions.
#

# References:
# - https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh#L31-L44
# - https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zlogin#L9-L15
# - http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Use-of-compinit
# - https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219
# - https://htr3n.github.io/2018/07/faster-zsh/

0=${(%):-%N}
zstyle -t ':zephyr:lib:bootstrap'    loaded || source ${0:a:h:h:h}/lib/bootstrap.zsh
zstyle -t ':zephyr:plugin:compstyle' loaded || source $ZEPHYR_HOME/plugins/compstyle/compstyle.plugin.zsh
#endregion

# Return if requirements are not met.
[[ "$TERM" != 'dumb' ]] || return 1
! zstyle -t ":zephyr:plugin:completion" skip || return 0

# Set completion options.
setopt always_to_end        # Move cursor to the end of a completed word.
setopt auto_list            # Automatically list choices on ambiguous completion.
setopt auto_menu            # Show completion menu on a successive tab press.
setopt auto_param_slash     # If completed parameter is a directory, add a trailing slash.
setopt complete_in_word     # Complete from both ends of a word.
setopt path_dirs            # Perform path search even on command names with slashes.
setopt NO_flow_control      # Disable start/stop characters in shell editor.
setopt NO_menu_complete     # Do not autoselect the first completion entry.

# Allow Fish-like user contributed completions.
fpath=($__zsh_config_dir/completions(-/FN) $fpath)

function run_compinit {
  emulate -L zsh
  setopt local_options extended_glob

  # Use ZSH_COMPDUMP for the completion file.
  typeset -g ZSH_COMPDUMP
  if [[ -z "$ZSH_COMPDUMP" ]]; then
    if zstyle -T ':zephyr:plugin:completion' use-xdg-basedirs; then
      ZSH_COMPDUMP=$__zsh_cache_dir/zcompdump
    else
      ZSH_COMPDUMP=$HOME/.zcompdump
    fi
  fi

  # Make sure ZSH_COMPDUMP's directory exists and doesnt' have a leading tilde.
  ZSH_COMPDUMP="${~ZSH_COMPDUMP}"
  [[ -d $ZSH_COMPDUMP:h ]] || mkdir -p $ZSH_COMPDUMP:h

  # `run_compinit -f` forces a cache reset.
  if [[ "$1" == (-f|--force) ]]; then
    shift
    [[ -r "$ZSH_COMPDUMP" ]] && rm -rf -- "$ZSH_COMPDUMP"
  fi

  # compinit flags: https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Use-of-compinit
  # -C        : Omit the check for new completion functions
  # -i        : Ignore insecure directories in fpath
  # -u        : Allow insecure directories in fpath
  # -d <file> : Specify zcompdump file
  local -a compinit_flags=(-i)
  if zstyle -t ':zephyr:plugin:completion' 'disable-compfix'; then
    compinit_flags=(-u)
  fi
  compinit_flags+=(-d "$ZSH_COMPDUMP")

  # Initialize completions
  autoload -Uz compinit
  if zstyle -t ':zephyr:plugin:completion' 'use-cache'; then
    # Load and initialize the completion system ignoring insecure directories with a
    # cache time of 20 hours, so it should almost always regenerate the first time a
    # shell is opened each day.
    local zcompdump_cache=($ZSH_COMPDUMP(Nmh-20))
    if (( $#zcompdump_cache )); then
      compinit -C $compinit_flags
    else
      compinit $compinit_flags
      touch "$ZSH_COMPDUMP"  # Ensure timestamp updates to reset the cache timeout.
    fi
  else
    compinit $compinit_flags
  fi

  # Compile ZSH_COMPDUMP, if modified, in background to increase startup speed.
  {
    if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
      if command mkdir "${ZSH_COMPDUMP}.zwc.lock" 2>/dev/null; then
        zcompile "$ZSH_COMPDUMP"
        command rmdir  "${ZSH_COMPDUMP}.zwc.lock" 2>/dev/null
      fi
    fi
  } &!
}

# Let's talk about compinit for a second...
# compinit works by finding _completion files in your fpath. That means fpath needs to
# be fully populated prior to calling it. But sometimes you need to call compdef before
# fpath is done being populated (eg: plugins do this). compinit has big chicken-and-egg
# problems. This code handles all those completion use-cases by wrapping compinit,
# queueing any calls to compdef, and hooking the real call to compinit to Zephyr's
# custom post_zshrc event.

# Define compinit placeholder functions (compdef) so we can queue up calls.
# That way when the real compinit is called, we can execute the queue.
typeset -gHa __compdef_queue=()
function compdef {
  (( $# )) || return
  local compdef_args=("${@[@]}")
  __compdef_queue+=("$(typeset -p compdef_args)")
}

# Wrap compinit temporarily so that when the real compinit call happens, the
# queue of compdef calls is processed.
function compinit {
  unfunction compinit compdef &>/dev/null
  autoload -Uz compinit && compinit "$@"

  # Apply all the queued compdefs.
  local typedef_compdef_args
  for typedef_compdef_args in $__compdef_queue; do
    eval $typedef_compdef_args
    compdef "$compdef_args[@]"
  done
  unset __compdef_queue

  # We can run compinit early, and if we did we no longer need a post_zshrc hook.
  post_zshrc_hook=(${post_zshrc_hook:#run_compinit})
}

# Set the completion style
zstyle -s ':zephyr:plugin:completion' compstyle 'zcompstyle' || zcompstyle=zephyr
if (( $+functions[compstyle_${zcompstyle}_setup] )); then
  compstyle_${zcompstyle}_setup
elif [[ "$zcompstyle" != none ]]; then
  compstyleinit
  compstyle ${zcompstyle}
fi
unset zcompstyle

# Allow the user to bypass the compinit deferral and run it immediately. Otherwise, we
# hook run_compinit to the custom post_zshrc event.
if zstyle -t ':zephyr:plugin:completion' immediate; then
  run_compinit || return 1
else
  post_zshrc_hook+=(run_compinit)
fi

#region MARK LOADED
zstyle ':zephyr:plugin:completion' loaded 'yes'
#endregion
