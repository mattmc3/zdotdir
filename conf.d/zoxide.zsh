#
# zoxide: Configure zoxide.
#

if ! (( $+commands[zoxide] )); then
  echo "zoxide not found" >&2
  return 1
fi

# https://github.com/ajeetdsouza/zoxide
if (( $+functions[cached-eval] )); then
  cached-eval 'zoxide-init-zsh' zoxide init zsh
else
  source <(zoxide init zsh)
fi
