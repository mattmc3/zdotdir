# remove sub-par git completion
# rm -f $HOMEBREW_PREFIX/share/zsh/site-functions/_git{,.zwc}

fpath=(
  $HOMEBREW_PREFIX/opt/curl/share/zsh/site-functions(/N)
  $ZPLUGINDIR/.external/git
  $ZPLUGINDIR/.external/zsh-completion/src
  $fpath
)

source $ZPLUGINDIR/.external/zsh-utils/completion/completion.plugin.zsh
compstyle zshzoo

zstyle ':completion:*:*:git:*' script $ZPLUGINDIR/.external/git/git-completion.bash

# Compile compdump, if modified, in background to increase startup speed.
: ${ZSH_COMPDUMP:=$XDG_CACHE_HOME/zsh/compdump}
{
  if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
    zcompile "$ZSH_COMPDUMP"
  fi
} &!
