### local ------------------------------------------------------------------ {{{
# if dotfiles/local has ZSH configs, let's load them
if [[ -f $DOTFILES/local/zsh/zshrc.local.zsh ]]; then
  . $DOTFILES/local/zsh/zshrc.local.zsh
fi
