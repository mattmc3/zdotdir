#
# p10k-instaprompt
#

[[ -z "$ZPROFRC" ]] || return 1
zstyle -m ':zsh:prompt' theme powerlevel10k || return 1

if zstyle -T ':zsh:prompt:powerlevel10k' instant-prompt; then
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi
