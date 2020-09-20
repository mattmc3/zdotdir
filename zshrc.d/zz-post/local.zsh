###
# local
# make sure that the dotfiles .zshrc.local exists
if [[ ! -f "${ZDOTDIR:-HOME}"/.zshrc.local ]] && [[ -f "${DOTFILES}"/local/zsh/zsh/zshrc.local.zsh ]]; then
  ln -s "${DOTFILES}"/local/zsh/zsh/zshrc.local.zsh "${ZDOTDIR:-HOME}"/.zshrc.local
fi
source "${ZDOTDIR:-HOME}"/.zshrc.local
