[[ -d "$ZDOTDIR/plugins/prezto" ]] || git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR}/plugins/prezto"
if [[ -s "${ZDOTDIR:-$HOME}/plugins/prezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/plugins/prezto/init.zsh"
fi
