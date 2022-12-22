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
