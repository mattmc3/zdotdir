# https://github.com/ajeetdsouza/zoxide
if (( $+commands[zoxide] )); then
  cached-eval 'zoxide-init-zsh' zoxide init zsh
fi
