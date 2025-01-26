# Run this early so we can P10k instant prompt if we need it.
[[ "$ZSH_THEME" == (p10k|powerlevel10k)* ]] || return 1
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
