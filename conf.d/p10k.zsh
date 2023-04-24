#
# powerlevel10k - romkatv/powerlevel10k prompt
#

(( $+functions[prompt_powerlevel9k_teardown] )) || return 1

# Set the prompt config
local prompt_config
zstyle -s ':zsh:prompt:powerlevel10k' config prompt_config
if [[ -n "$prompt_config" ]]; then
  prompt_config=$ZDOTDIR/themes/${prompt_config}.p10k.zsh

  # To customize prompt, run `p10k configure` or edit ${ZDOTDIR:-~}/.p10k.zsh.
  [[ -f $prompt_config ]] || prompt_config=${ZDOTDIR:-~}/.p10k.zsh
  source $prompt_config
fi
