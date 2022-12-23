0=${(%):-%N}
autoload-dir ${0:A:h}/functions

# remove sub-par git completion
# rm -f $HOMEBREW_PREFIX/share/zsh/site-functions/_git{,.zwc}

fpath=(
  $HOMEBREW_PREFIX/opt/curl/share/zsh/site-functions(/N)
  $ZPLUGINDIR/.external/git
  $ZPLUGINDIR/.external/zsh-completion/src
  $fpath
)

#
# Requirements
#

[[ "$TERM" != 'dumb' ]] || return 1

: ${ZSH_COMPDUMP:=${XDG_CACHE_HOME:=$HOME/.cache}/zsh/compdump}
[[ -d $ZSH_COMPDUMP:h ]] || mkdir -p $ZSH_COMPDUMP:h

#
# Options
#

setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit
setopt NO_MENU_COMPLETE    # Do not autoselect the first completion entry.
setopt NO_FLOW_CONTROL     # Disable start/stop characters in shell editor.

#
# Styles
#

# Use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$XDG_CACHE_HOME/zsh/compcache"

#
# Init
#

# Initialize completion styles. Users can set their preferred completion style by
# calling `compstyle <compstyle>` in their .zshrc, or by defining their own
# `compstyle_<name>_setup` functions similar to the zsh prompt system.
# fpath+="${0:A:h}/functions"
# autoload -Uz compstyleinit && compstyleinit


# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day.
autoload -Uz compinit
_comp_files=($ZSH_COMPDUMP(Nmh-20))
if (( $#_comp_files )); then
  compinit -i -C -d "$ZSH_COMPDUMP"
else
  compinit -i -d "$ZSH_COMPDUMP"
fi

# Compile compdump, if modified, in background to increase startup speed.
{
  if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
    zcompile "$ZSH_COMPDUMP"
  fi
} &!

# Set compstyles
compstyle_mattmc3_setup
zstyle ':completion:*:*:git:*' script $ZPLUGINDIR/.external/git/git-completion.bash

#
# Cleanup
#

unset _comp_files
