# local overrides
if [[ ! -f $ZDOTDIR/zshrc.local.zsh ]] && [[ -f $DOTFILES.local/zsh/zshrc.local.zsh ]]; then
  ln -s $DOTFILES.local/zsh/zshrc.local.zsh $ZDOTDIR/zshrc.local.zsh
fi
if [[ ! -d $ZDOTDIR/functions.local ]] && [[ -d $DOTFILES.local/zsh/functions ]]; then
  ln -s $DOTFILES.local/zsh/functions $ZDOTDIR/functions.local
fi

[[ -f $ZDOTDIR/zshrc.local.zsh ]] && . $ZDOTDIR/zshrc.local.zsh
local _fn
for _fn in $ZDOTDIR/functions.local/*(.); do
  (( $+functions[${_fn:t}] )) && unfunction "${_fn:t}"
  autoload -Uz "$_fn"
done
unset _fn
