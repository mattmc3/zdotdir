#
# prompt: Setup Zsh prompt.
#

# 16.2.8 Prompting
setopt prompt_subst       # Expand parameters in prompt variables.
setopt transient_rprompt  # Remove right prompt artifacts from prior commands.

# If starship is installed, then let's hook it into Zsh's prompt system.
if (( $+commands[starship] )); then
  function prompt_starship_setup {
    # When loaded through the prompt command, these prompt_* options will be enabled
    prompt_opts=(cr percent sp subst)

    if [[ -n "$1" ]]; then
      local -a configs=(
        $__zsh_config_dir/themes/$1.toml(N)
        ${XDG_CONFIG_HOME:-$HOME/.config}/starship/$1.toml(N)
      )
      (( $#configs )) && export STARSHIP_CONFIG=$configs[1]
    fi

    # Cache the output of 'starship init zsh'
    local starship_init=$__zsh_cache_dir/starship_init.zsh
    local cache=($starship_init(Nmh-20))
    (( $#cache )) || starship init zsh >| $starship_init
    source $starship_init
  }
fi

function myprompt {
  # Initialize built-in prompt system.
  autoload -Uz promptinit && promptinit
  if [[ $TERM == dumb ]] || (( $# == 0 )); then
    prompt 'off'
    return
  fi

  if (( $+functions[prompt_powerlevel10k_setup] )); then
    function prompt_p10k_setup {
      if [[ -n "$1" ]]; then
        local -a configs=($__zsh_config_dir/themes/$1.p10k.zsh(N))
        (( $#configs )) && source $configs[1]
      fi
      prompt_powerlevel10k_setup
    }
  fi

  # Since we have defined explicit prompt functions and not as autoload files in $fpath,
  # we need to stick the theme's name into `$prompt_themes' ourselves, since promptinit
  # does not pick them up otherwise.
  prompt_themes+=( p10k starship )
  prompt_themes=( "${(@on)prompt_themes}" )  # Also, keep the array sorted...

  # Set prompt.
  prompt "$@[@]"

  # Mark theme as loaded.
  zstyle ':myzsh:feature:prompt:theme' loaded yes
}
