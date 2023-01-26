#
# Options
#

# Set prompt options
typeset -ga zopts_prompt=(
  PROMPT_SUBST   # Substitute environment variables in prompt variables.
)
setopt $zopts_prompt

#
# Init
#

fpath=(${0:A:h}/functions $fpath)
autoload -Uz $fpath[1]/*(.:t)

if zstyle -s ':zshzoo:plugin:prompt:starship' config _toml; then
  export STARSHIP_CONFIG=${0:A:h}/themes/${_toml}.toml
fi
unset _toml

zstyle -s ':zshzoo:plugin:prompt' theme 'theme_name' ||
  theme_name=${ZSH_THEME:-pure}

prompt_${theme_name}_setup

unset theme_name

# vim: ft=zsh
