() {
  local -a prompt_argv
  zstyle -a ':zephyr:plugin:prompt' theme 'prompt_argv'
  [[ "$prompt_argv[1]" == powerlevel10k ]] || [[ "$prompt_argv[1]" == p10k ]]
} || return 1

# Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
