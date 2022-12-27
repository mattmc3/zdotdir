# load zprof first if we need to profile
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
[[ "$ZPROFRC" -eq 1 ]] && typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zsh options
setopt extended_glob

# Use a zsh home other than $HOME.
zhome=${ZDOTDIR:-${XDG_CONFIG_HOME:-~/.config}/zsh}

# conf.d
for rcfile in $zhome/conf.d/*.zsh(.N); do
  [[ ${rcfile:t} != '~'* ]] || continue
  source "$rcfile"
done

# Set aliases.
source $zhome/lib/alias.zsh

# Cleanup
unset zhome rcfile

# done profiling
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
