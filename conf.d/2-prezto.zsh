[[ -d "$ZDOTDIR/plugins/prezto" ]] || zshplug install sorin-ionescu/prezto
if [[ -s "${ZDOTDIR}/plugins/prezto/init.zsh" ]]; then
  source "${ZDOTDIR}/plugins/prezto/init.zsh"
fi
