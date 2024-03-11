#
# completion: Options and config related to completions.
#

# Add Fish-like custom completions directory.
fpath=($__zsh_config_dir/completions(/N) $fpath)

# 16.2.2 Completion
setopt always_to_end     # Move cursor to the end of a completed word.
setopt auto_list         # Automatically list choices on ambiguous completion.
setopt auto_menu         # Show completion menu on a successive tab press.
setopt auto_param_slash  # If completed parameter is a directory, add a trailing slash.
setopt complete_in_word  # Complete from both ends of a word.
setopt NO_menu_complete  # Do not autoselect the first completion entry.

# Initialize completions.
function mycompinit {
  typeset -g ZSH_COMPDUMP=${ZSH_COMPDUMP:-$__zsh_cache_dir/compdump}
  export ZSH_COMPDUMP

  # Force cache reset flag
  [[ "$1" == "-f" ]] && [[ -f "$ZSH_COMPDUMP" ]] && rm -rf -- $ZSH_COMPDUMP

  # Load and initialize the completion system ignoring insecure directories with a
  # cache time of 20 hours, so it should almost always regenerate the first time a
  # shell is opened each day.
  autoload -Uz compinit
  local compdump_cache=($ZSH_COMPDUMP(Nmh-20))
  if (( $#compdump_cache )); then
    compinit -i -C -d "$ZSH_COMPDUMP"
  else
    compinit -i -d "$ZSH_COMPDUMP"
    # Ensure $ZSH_COMPDUMP is younger than the cache time even if it isn't regenerated.
    touch "$ZSH_COMPDUMP"
  fi
}
