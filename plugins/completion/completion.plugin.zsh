####
# completion - Set up zsh completions.
###

#
# Requirements
#

[[ "$TERM" != 'dumb' ]] || return 1

#
# Init
#

fpath=(
  # add git completions if they exist
  $ZEPHYR_HOME/.external/git(/N)

  # add curl completions from homebrew if they exist
  /{usr,opt}/{local,homebrew}/opt/curl/share/zsh/site-functions(-/FN)

  # add zsh completions
  /{usr,opt}/{local,homebrew}/share/zsh/site-functions(-/FN)

  # add zsh-users completions if they exist
  $ZEPHYR_HOME/.external/zsh-completion/src(-/FN)

  # Allow user completions.
  ${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/completions(-/FN)

  # this plugin and rest of fpath
  ${0:A:h}/functions
  $fpath
)

function compstyleinit() {}

# Use zsh-utils completion.
source $ZEPHYR_HOME/.external/zsh-utils/completion/completion.plugin.zsh

# Compile compdump, if modified, in background to increase startup speed.
: ${ZSH_COMPDUMP:=${XDG_CACHE_HOME:=$HOME/.cache}/zsh/compdump}
{
  if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
    zcompile "$ZSH_COMPDUMP"
  fi
} &!

# Set compstyles
autoload -Uz compstyle_mattmc3_setup && compstyle_mattmc3_setup
zstyle ':completion:*:*:git:*' script $ZPLUGINDIR/.external/git/git-completion.bash
