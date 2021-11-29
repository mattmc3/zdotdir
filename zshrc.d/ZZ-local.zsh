# local overrides
if [[ ! -f $ZDOTDIR/zshrc.local.zsh ]] && [[ -f $DOTFILES.local/zsh/zshrc.local.zsh ]]; then
  ln -s $DOTFILES.local/zsh/zshrc.local.zsh $ZDOTDIR/zshrc.local.zsh
fi

[[ -f $ZDOTDIR/zshrc.local.zsh ]] && . $ZDOTDIR/zshrc.local.zsh
