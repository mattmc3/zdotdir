### local ------------------------------------------------------------------ {{{
if [[ -f "${ZDOTDIR:-HOME}"/.zshrc.local ]]; then
  . "${ZDOTDIR:-HOME}"/.zshrc.local
elif [[ -f "${DOTFILES}"/local/zsh/zsh/zshrc.local.zsh ]]; then
  . "${DOTFILES}"/local/zsh/zsh/zshrc.local.zsh
fi
