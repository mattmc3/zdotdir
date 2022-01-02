if [[ ! -e ${ZDOTDIR:-~/.config/zsh}/.zsh_history ]] && [[ -e $HISTFILE ]]; then
  ln -s $HISTFILE ${ZDOTDIR:-~/.config/zsh}/.zsh_history
fi
