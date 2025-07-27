#region HEADER
#
# prompt: Set zsh prompt.
#

0=${(%):-%N}
zstyle -t ':zephyr:lib:bootstrap' loaded || source ${0:a:h:h:h}/lib/bootstrap.zsh
#endregion

# Support skipping this plugin - useful if loading everything through zephyr.zsh.
! zstyle -t ":zephyr:plugin:prompt" skip || return 0

# Prompt options
setopt prompt_subst       # Expand parameters in prompt variables.
#setopt transient_rprompt  # Remove right prompt artifacts from prior commands.

# Set 2 space indent for each new level in a multi-line script. This can then be
# overridden by a prompt or plugin, but is a better default than Zsh's.
PS2='${${${(%):-%_}//[^ ]}// /  }    '

# Wrap powerlevel10k prompt to support themes directory
function prompt_p10k_setup {
  if [[ -n "$1" ]]; then
    local -a configs=($__zsh_config_dir/themes/$1.p10k.zsh(N))
    (( $#configs )) && source $configs[1]
  fi
  prompt_powerlevel10k_setup
}

# Make starship work with built-in prompt system.
function prompt_starship_setup {
  # When loaded through the prompt command, these prompt_* options will be enabled
  prompt_opts=(cr percent sp subst)

  # Set the starship config based on the argument if provided.
  if [[ -n "$1" ]]; then
    local -a configs=(
      "$__zsh_config_dir/themes/${1}.toml"(N)
      "${XDG_CONFIG_HOME:-$HOME/.config}/starship/${1}.toml"(N)
      "$ZEPHYR_HOME/plugins/prompt/themes/${1}.toml"(N)
    )
    (( $#configs )) && export STARSHIP_CONFIG=$configs[1]
  fi

  # Initialize starship.
  if zstyle -t ':zephyr:plugin:prompt' 'use-cache'; then
    cached-eval 'starship-init-zsh' starship init zsh
  else
    source <(starship init zsh)
  fi
}

# Wrap promptinit.
function promptinit {
  # Initialize real built-in prompt system.
  unfunction promptinit
  autoload -Uz promptinit && promptinit

  # Hook P10k into Zsh's prompt system.
  (( $+functions[prompt_powerlevel10k_setup] )) \
    && prompt_themes+=( p10k ) \
    || unfunction prompt_p10k_setup

  # Hook starship into Zsh's prompt system.
  (( $+commands[starship] )) \
    && prompt_themes+=( starship ) \
    || unfunction prompt_starship_setup

  # Keep prompt array sorted.
  prompt_themes=( "${(@on)prompt_themes}" )

  # We can run promptinit early, and if we did we no longer need a post_zshrc hook.
  post_zshrc_hook=(${post_zshrc_hook:#run_promptinit})
}

function run_promptinit {
  # Initialize the built-in prompt system.
  autoload -Uz promptinit && promptinit

  # Set the prompt if specified.
  local -a prompt_argv
  zstyle -a ':zephyr:plugin:prompt' theme 'prompt_argv' \
    || prompt_argv=(starship zephyr)
  if [[ $TERM == (dumb|linux|*bsd*) ]]; then
    prompt 'off'
  elif (( $#prompt_argv > 0 )); then
    prompt "$prompt_argv[@]"
  fi
}

# Allow the user to bypass the confd deferral and run it immediately. Otherwise, we
# hook run_confd to the custom post_zshrc event.
if zstyle -t ':zephyr:plugin:prompt' immediate; then
  run_promptinit || return 1
else
  post_zshrc_hook+=(run_promptinit)
fi

#region MARK LOADED
zstyle ":zephyr:plugin:prompt" loaded 'yes'
#endregion
